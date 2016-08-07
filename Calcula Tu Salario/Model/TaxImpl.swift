import Foundation

//MARK: Constants

private enum ISRPercentage {
  static let firstScalePercentage: NSDecimalNumber = 0.15
  static let secondScalePercentage: NSDecimalNumber = 0.20
  static let thirdScalePercentage: NSDecimalNumber = 0.25
}

private enum Scale {
  static let exemptFromISRScale: NSDecimalNumber = 409_281.00
  static let lowerBoundFirstScale: NSDecimalNumber = 409_281.01
  static let higherBoundFirstScale: NSDecimalNumber = 613_921.00
  static let lowerBoundSecondScale: NSDecimalNumber = 613_921.01
  static let higherBoundSecondScale: NSDecimalNumber = 852_667.00
  static let lowerBoundThirdScale: NSDecimalNumber = 852_667.01
}

private enum RateNumber {
  static let secondScaleRateNumber: NSDecimalNumber = 30_696.00
  static let thirdScaleRateNumber: NSDecimalNumber = 78_446.00
}

private enum TaxPercentage {
  static let AFP: NSDecimalNumber = 0.0287
  static let SFS: NSDecimalNumber = 0.0304
}

//MARK: Tax Implementation

extension Tax {
  
  func isSalaryExemptFromISR(salary: NSDecimalNumber) -> Bool {
    let yearlySalary: NSDecimalNumber = calculateYearlySalary(salary)
    
    let isSalaryExemptFromISR = yearlySalary < Scale.exemptFromISRScale
    
    if isSalaryExemptFromISR {
      return true
    }
    return false
  }
  
  func getPercentage(salary: NSDecimalNumber) -> NSDecimalNumber {
    
    let yearlySalary = calculateYearlySalary(salary)
    let salaryDoesNotApplyForISR: NSDecimalNumber = 0.0
    
    let isSalaryInFirstScale = yearlySalary >= Scale.lowerBoundFirstScale
      && yearlySalary <= Scale.higherBoundFirstScale
    
    let isSalaryInSecondScale = yearlySalary >= Scale.lowerBoundSecondScale
      && yearlySalary <= Scale.higherBoundSecondScale
    
    let isSalaryInThirdScale = yearlySalary >= Scale.lowerBoundThirdScale
      && yearlySalary <= NSDecimalNumber(double: DBL_MAX)
    
    if isSalaryInFirstScale {
      return ISRPercentage.firstScalePercentage
    }
      
    else if isSalaryInSecondScale {
      return ISRPercentage.secondScalePercentage
    }
      
    else if isSalaryInThirdScale {
      return ISRPercentage.thirdScalePercentage
    }
    
    return salaryDoesNotApplyForISR
  }
  
  func getSurplus(salary: NSDecimalNumber) -> NSDecimalNumber {
    
    let ISRDeductionPercentage = getPercentage(salary)
    let firstScale = ISRPercentage.firstScalePercentage
    let secondScale = ISRPercentage.secondScalePercentage
    let thirdScale = ISRPercentage.thirdScalePercentage
    
    switch ISRDeductionPercentage {
    case firstScale:
      return Scale.lowerBoundFirstScale
    case secondScale:
      return Scale.lowerBoundSecondScale
    case thirdScale:
      return Scale.lowerBoundThirdScale
    default:
      return 0.0
    }
    
  }
  
  func getRateNumber(percent: NSDecimalNumber) -> NSDecimalNumber {
    
    let secondScale = ISRPercentage.secondScalePercentage
    let thirdScale = ISRPercentage.thirdScalePercentage
    
    switch percent {
    case secondScale:
      return RateNumber.secondScaleRateNumber
    case thirdScale:
      return RateNumber.thirdScaleRateNumber
    default:
      return 0.0
    }
  }
  
  func getYearlyRetentionAmount(salary: NSDecimalNumber) -> NSDecimalNumber {
    
    let yearlySalary = calculateYearlySalary(salary)
    let ISRSurplus = getSurplus(salary)
    let yearlySalaryMinusSurplusResult = yearlySalary - ISRSurplus
    let ISRPercentage = getPercentage(salary)
    var totalISRRetention = yearlySalaryMinusSurplusResult * ISRPercentage
    
    let rateNumber = getRateNumber(ISRPercentage)
    
    if rateNumber != 0.0 {
      totalISRRetention = totalISRRetention + rateNumber
    }
    return NSDecimalNumber.roundToNearestTwo(totalISRRetention)
  }
  
  func getMonthlyRetentionAmount(salary: NSDecimalNumber) -> NSDecimalNumber {
    return NSDecimalNumber.roundToNearestTwo(getYearlyRetentionAmount(salary) / 12)
  }
  
  func getBiWeeklyRetentionAmount(salary: NSDecimalNumber) -> NSDecimalNumber {
    return NSDecimalNumber.roundToNearestTwo(getMonthlyRetentionAmount(salary) / 2)
  }
  
  
  func obtainDeductions(forSalary salary: NSDecimalNumber) -> [String: NSDecimalNumber] {
    
    let tax: (AFP: NSDecimalNumber, SFS: NSDecimalNumber) =
      (salary * TaxPercentage.AFP, salary * TaxPercentage.SFS)
    
    let isr = getMonthlyRetentionAmount(salary - tax.AFP - tax.SFS)
    
    var taxDeductions: [String: NSDecimalNumber] = [
      "AFP": tax.AFP,
      "SFS": tax.SFS,
      "ISR": isr
    ]
    
    roundTax(&taxDeductions)
    return taxDeductions
  }
  
}

private func calculateYearlySalary(salary: NSDecimalNumber) -> NSDecimalNumber {
  let oneYear: NSDecimalNumber = 12.0
  return salary * oneYear
}

private func roundTax(inout taxDeductions: [String: NSDecimalNumber]) {
  for (key, value) in taxDeductions {
    taxDeductions[key] = NSDecimalNumber.roundToNearestTwo(value)
  }
}
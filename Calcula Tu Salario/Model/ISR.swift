import Foundation

private enum Percentage {
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


struct ISR {
  
  static func isSalaryExemptFromISR(salary: NSDecimalNumber) -> Bool {
    let yearlySalary: NSDecimalNumber = calculateYearlySalary(salary)
    
    let isSalaryExemptFromISR = yearlySalary < Scale.exemptFromISRScale
    
    if isSalaryExemptFromISR {
      return true
    }
    return false
  }
  
  static func getPercentage(salary: NSDecimalNumber) -> NSDecimalNumber {
    
    let yearlySalary = calculateYearlySalary(salary)
    
    let isSalaryInFirstScale = yearlySalary >= Scale.lowerBoundFirstScale
      && yearlySalary <= Scale.higherBoundFirstScale
    
    let isSalaryInSecondScale = yearlySalary >= Scale.lowerBoundSecondScale
      && yearlySalary <= Scale.higherBoundSecondScale
    
    let isSalaryInThirdScale = yearlySalary >= Scale.lowerBoundThirdScale
      && yearlySalary <= NSDecimalNumber(double: DBL_MAX)
    
    if isSalaryInFirstScale {
      return Percentage.firstScalePercentage
    }
      
    else if isSalaryInSecondScale {
      return Percentage.secondScalePercentage
    }
      
    else if isSalaryInThirdScale {
      return Percentage.thirdScalePercentage
    }
    
    return 0.0
  }

  static func getSurplus(salary: NSDecimalNumber) -> NSDecimalNumber {
    
    let ISRPercentage = getPercentage(salary)
    let firstScale = Percentage.firstScalePercentage
    let secondScale = Percentage.secondScalePercentage
    let thirdScale = Percentage.thirdScalePercentage
    
    switch ISRPercentage {
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

  static func getRateNumber(percent: NSDecimalNumber) -> NSDecimalNumber {
    
    let secondScale = Percentage.secondScalePercentage
    let thirdScale = Percentage.thirdScalePercentage
    
    switch percent {
    case secondScale:
      return RateNumber.secondScaleRateNumber
    case thirdScale:
      return RateNumber.thirdScaleRateNumber
    default:
      return 0.0
    }
  }

  static func getYearlyRetentionAmount(salary: NSDecimalNumber) -> NSDecimalNumber {
    
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
  
  static func getMonthlyRetentionAmount(salary: NSDecimalNumber) -> NSDecimalNumber {
    return NSDecimalNumber.roundToNearestTwo(getYearlyRetentionAmount(salary) / 12)
  }
  
  static func getBiWeeklyRetentionAmount(salary: NSDecimalNumber) -> NSDecimalNumber {
    return NSDecimalNumber.roundToNearestTwo(getMonthlyRetentionAmount(salary) / 2)
  }

}

private func calculateYearlySalary(salary: NSDecimalNumber) -> NSDecimalNumber {
  let oneYear: NSDecimalNumber = 12.0
  return salary * oneYear
}



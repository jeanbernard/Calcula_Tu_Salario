//
//  ISR.swift
//  Calcula Tu Salario
//
//  Created by Jean Bernard on 6/30/16.
//  Copyright © 2016 Jean Bernard. All rights reserved.
//

import Foundation
import Darwin

private struct Percentage {
  static let FirstScalePercentage: NSDecimalNumber = 0.15
  static let SecondScalePercentage: NSDecimalNumber = 0.20
  static let ThirdScalePercentage: NSDecimalNumber = 0.25
}

private struct Scale {
  static let ExemptFromISRScale: NSDecimalNumber = 409_281.00
  static let LowerBoundFirstScale: NSDecimalNumber = 409_281.01
  static let HigherBoundFirstScale: NSDecimalNumber = 613_921.00
  static let LowerBoundSecondScale: NSDecimalNumber = 613_921.01
  static let HigherBoundSecondScale: NSDecimalNumber = 852_667.00
  static let LowerBoundThirdScale: NSDecimalNumber = 852_667.01
}

private struct RateNumber {
  static let SecondScaleRateNumber: NSDecimalNumber = 30_696.00
  static let ThirdScaleRateNumber: NSDecimalNumber = 78_446.00
}


struct ISR {
  
  static func isSalaryExemptFromISR(salary: NSDecimalNumber) -> Bool {
    let yearlySalary: NSDecimalNumber = calculateYearlySalary(salary)
    
    let isSalaryExemptFromISR = yearlySalary < Scale.ExemptFromISRScale
    
    if isSalaryExemptFromISR {
      return true
    }
    return false
  }
  
  static func getPercentage(salary: NSDecimalNumber) -> NSDecimalNumber {
    
    let yearlySalary = calculateYearlySalary(salary)
    
    let isSalaryInFirstScale = yearlySalary >= Scale.LowerBoundFirstScale
      && yearlySalary <= Scale.HigherBoundFirstScale
    
    let isSalaryInSecondScale = yearlySalary >= Scale.LowerBoundSecondScale
      && yearlySalary <= Scale.HigherBoundSecondScale
    
    let isSalaryInThirdScale = yearlySalary >= Scale.LowerBoundThirdScale
      && yearlySalary <= NSDecimalNumber(double: DBL_MAX)
    
    if isSalaryInFirstScale {
      return Percentage.FirstScalePercentage
    }
      
    else if isSalaryInSecondScale {
      return Percentage.SecondScalePercentage
    }
      
    else if isSalaryInThirdScale {
      return Percentage.ThirdScalePercentage
    }
    
    return 0.0
  }

  static func getSurplus(salary: NSDecimalNumber) -> NSDecimalNumber {
    
    let ISRPercentage = getPercentage(salary)
    
    switch ISRPercentage {
    case Percentage.FirstScalePercentage:
      return Scale.LowerBoundFirstScale
    case Percentage.SecondScalePercentage:
      return Scale.LowerBoundSecondScale
    case Percentage.ThirdScalePercentage:
      return Scale.LowerBoundThirdScale
    default:
      return 0.0
    }
    
  }

  static func getRateNumber(percent: NSDecimalNumber) -> NSDecimalNumber {
    
    switch percent {
    case Percentage.SecondScalePercentage:
      return RateNumber.SecondScaleRateNumber
    case Percentage.ThirdScalePercentage:
      return RateNumber.ThirdScaleRateNumber
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



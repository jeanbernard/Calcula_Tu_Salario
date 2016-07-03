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
  static let FirstScalePercentage = 0.15
  static let SecondScalePercentage = 0.20
  static let ThirdScalePercentage = 0.25
}

private struct Scale {
  static let ExemptFromISRScale = 409_281.00
  static let LowerBoundFirstScale = 409_281.01
  static let HigherBoundFirstScale = 613_921.00
  static let LowerBoundSecondScale = 613_921.01
  static let HigherBoundSecondScale = 852_667.00
  static let LowerBoundThirdScale = 852_667.01
}

private struct RateNumber {
  static let SecondScaleRateNumber = 30_696.00
  static let ThirdScaleRateNumber = 78_446.00
}

/*
 NSOrderedAscending if the value of decimalNumber is greater than the receiver;
 NSOrderedSame if they’re equal; 
 NSOrderedDescending if the value of decimalNumber is less than the receiver. 
 */


struct ISR {
  
  static func doesSalaryApplyForISR(salary: NSDecimalNumber) -> Bool {
    
    let yearlySalary: NSDecimalNumber = calculateYearlySalary(salary)

    if yearlySalary.compare(Scale.ExemptFromISRScale).rawValue == -1 {
      return false
    } else {
      return true
    }
  
  }
  
//  static func getPercentage(salary: NSDecimalNumber) -> Double {
//    
//    let yearlySalary: NSDecimalNumber = calculateYearlySalary(salary)
//    
//    switch Double(yearlySalary) {
//    case Scale.LowerBoundFirstScale...Scale.HigherBoundFirstScale:
//      return Percentage.FirstScalePercentage
//    case Scale.LowerBoundSecondScale...Scale.HigherBoundSecondScale:
//      return Percentage.SecondScalePercentage
//    case Scale.LowerBoundThirdScale...DBL_MAX:
//      return Percentage.ThirdScalePercentage
//    default:
//      return 0.0
//    }
//  }
//
//  static func getSurplus(salary: Double) -> Double {
//    
//    let ISRPercentage = getPercentage(salary)
//    
//    switch ISRPercentage {
//    case Percentage.FirstScalePercentage:
//      return Scale.LowerBoundFirstScale
//    case Percentage.SecondScalePercentage:
//      return Scale.LowerBoundSecondScale
//    case Percentage.ThirdScalePercentage:
//      return Scale.LowerBoundThirdScale
//    default:
//      return 0.0
//    }
//    
//  }
//  
//  static func getRateNumber(percent: Double) -> Double {
//    
//    switch percent {
//    case Percentage.SecondScalePercentage:
//      return RateNumber.SecondScaleRateNumber
//    case Percentage.ThirdScalePercentage:
//      return RateNumber.ThirdScaleRateNumber
//    default:
//      return 0.0
//    }
//    
//  }
//  
//  static func getYearlyRetentionAmount(salary: Double) -> Double {
//    let yearlySalary = calculateYearlySalary(salary)
//    let ISRSurplus = getSurplus(salary)
//    let yearlySalaryMinusSurplusResult = Double.roundToNearestTwo(yearlySalary - ISRSurplus)
//    let ISRPercentage = getPercentage(salary)
//    var totalISRRetention = Double.roundToNearestTwo(yearlySalaryMinusSurplusResult * ISRPercentage)
//    
//    let rateNumber = getRateNumber(ISRPercentage)
//    
//    if rateNumber != 0.0 {
//      totalISRRetention += rateNumber
//    }
//    return Double.roundToNearestTwo(totalISRRetention)
//  }
//  
//  static func getMontlyRetentionAmount(salary: Double) -> Double {
//    return Double.roundToNearestTwo(getYearlyRetentionAmount(salary) / 12)
//  }
//  
//  static func getBiWeeklyRetentionAmount(salary: Double) -> Double {
//    return getMontlyRetentionAmount(salary) / 2
//  }
//  
}

private func calculateYearlySalary(salary: NSDecimalNumber) -> NSDecimalNumber {
  let oneYear: NSDecimalNumber = 12.0
  return salary.decimalNumberByMultiplyingBy(oneYear)
}

//
//  Wage.swift
//  Calcula Tu Salario
//
//  Created by Jean Bernard on 7/8/16.
//  Copyright © 2016 Jean Bernard. All rights reserved.
//

import Foundation

private enum HourlyPay: NSDecimalNumber {
  case Monthly = 23.83
}


struct Overtime {
  
  static func calculateHourlyWagePerMonth(wage: NSDecimalNumber, hoursWorked: NSDecimalNumber) -> NSDecimalNumber {
    
    let hourlyWagePerMonth = (wage / HourlyPay.Monthly.rawValue) / hoursWorked
    
    return NSDecimalNumber.roundToNearestTwo(hourlyWagePerMonth)
  }
  
}
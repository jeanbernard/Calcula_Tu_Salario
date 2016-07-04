//
//  Deduction.swift
//  Calcula Tu Salario
//
//  Created by Jean Bernard on 6/30/16.
//  Copyright © 2016 Jean Bernard. All rights reserved.
//

import Foundation
import Darwin

struct Deduction {
  
  enum TaxDeductions: NSDecimalNumber {
    case AFP = 0.0287
    case SFS = 0.0304
  }
  
  static func calculateAFPDeduction(salary: NSDecimalNumber) -> NSDecimalNumber {
    let afpDeduction = salary.decimalNumberByMultiplyingBy(TaxDeductions.AFP.rawValue)
    return NSDecimalNumber.roundToNearestTwo(afpDeduction)
  }
  
  static func calculateSFSDeduction(salary: NSDecimalNumber) -> NSDecimalNumber {
    let sfsDeduction = salary.decimalNumberByMultiplyingBy(TaxDeductions.SFS.rawValue)
    return NSDecimalNumber.roundToNearestTwo(sfsDeduction)
  }
  
  static func applyGovernmentTaxesToSalary(salary: NSDecimalNumber) -> NSDecimalNumber {
    let afpDeduction = Deduction.calculateAFPDeduction(salary)
    let sfsDeduction = Deduction.calculateSFSDeduction(salary)
    let totalDeductions = afpDeduction.decimalNumberByAdding(sfsDeduction)
    let salaryAfterGovernmentTaxes = salary.decimalNumberBySubtracting(totalDeductions)
    return salaryAfterGovernmentTaxes
  }
  
}





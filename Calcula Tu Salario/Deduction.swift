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
  var name: String
  var amount: Double
  
  enum TaxDeductions: Double {
    case AFP = 0.0287
    case SFS = 0.0304
  }
  
  static func applyGovernmentTaxesToSalary(salary: Double) -> Double {
    let afpDeduction = salary * TaxDeductions.AFP.rawValue
    let sfsDeduction = salary * TaxDeductions.SFS.rawValue
    let totalDeductions = Double.roundToNearestTwo(afpDeduction + sfsDeduction)
    let salaryAfterGovernmentTaxes = floor(salary - totalDeductions)
    return salaryAfterGovernmentTaxes
  }
  
}





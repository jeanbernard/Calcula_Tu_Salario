//import Foundation
//
//struct Payroll {
//  
//  static func calculateAFP_SFS(salary: NSDecimalNumber) -> NSDecimalNumber {
//    let salaryAfterAFP_SFS = Deduction.applyGovernmentTaxesToSalary(salary)
//    return salaryAfterAFP_SFS
//  }
//  
//  static func calculateMonthlyNetSalary(salary: NSDecimalNumber) -> NSDecimalNumber {
//    let salaryAfterAFP_SFS = Deduction.applyGovernmentTaxesToSalary(salary)
//    let salaryISRDeductionAmount = ISR.getMontlyRetentionAmount(salaryAfterAFP_SFS)
//    let netSalary: NSDecimalNumber = salaryAfterAFP_SFS - salaryISRDeductionAmount
//    
//    return netSalary
//  }
//  
//  static func calculateBiWeeklyNetSalary(salary: NSDecimalNumber) -> NSDecimalNumber {
//    let calculateSalary = calculateMonthlyNetSalary(salary)
//    return NSDecimalNumber.roundToNearestTwo(calculateSalary / 2)
//
//  }
//  
//}
import Foundation

struct Deduction {
  
  private enum TaxDeductions {
    static let AFP: NSDecimalNumber = 0.0287
    static let SFS: NSDecimalNumber = 0.0304
  }
  
  static func calculateAFP(salary: NSDecimalNumber) -> NSDecimalNumber {
    let afpDeduction = salary * TaxDeductions.AFP
    return NSDecimalNumber.roundToNearestTwo(afpDeduction)
  }
  
  static func calculateSFS(salary: NSDecimalNumber) -> NSDecimalNumber {
    let sfsDeduction = salary * TaxDeductions.SFS
    return NSDecimalNumber.roundToNearestTwo(sfsDeduction)
  }
  
  static func applyGovernmentTaxesToSalary(salary: NSDecimalNumber) -> NSDecimalNumber {
    let afpDeduction = Deduction.calculateAFP(salary)
    let sfsDeduction = Deduction.calculateSFS(salary)
    let totalDeductions = afpDeduction + sfsDeduction
    let salaryAfterGovernmentTaxes = salary - totalDeductions
    return salaryAfterGovernmentTaxes
  }
  
}




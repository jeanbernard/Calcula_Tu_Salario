import Foundation

struct Payroll {
  
  static func calculateAFP_SFS(salary: NSDecimalNumber) -> NSDecimalNumber {
    let salaryAfterAFP_SFS = Deduction.applyGovernmentTaxesToSalary(salary)
    return salaryAfterAFP_SFS
  }
  
  static func calculateMonthlyNetSalary(salary: NSDecimalNumber) -> NSDecimalNumber {
    let salaryAfterAFP_SFS = Deduction.applyGovernmentTaxesToSalary(salary)
    let salaryISRDeductionAmount = ISR.getMonthlyRetentionAmount(salaryAfterAFP_SFS)
    let netSalary = salaryAfterAFP_SFS - salaryISRDeductionAmount
    
    return netSalary
  }
  
  static func calculateBiWeeklyNetSalary(salary: NSDecimalNumber) -> NSDecimalNumber {
    let calculateSalary = calculateMonthlyNetSalary(salary)
    return NSDecimalNumber.roundToNearestTwo(calculateSalary / 2)
  }
  
  static func netSalaryWithOvertimePay(salary salary: NSDecimalNumber, workingHours: NSDecimalNumber, hoursWorked: NSDecimalNumber, frequency: PaymentFrequency) -> NSDecimalNumber {
    
    let salaryAfterAFP_SFS = Deduction.applyGovernmentTaxesToSalary(salary)
    let totalDeductions = salary - salaryAfterAFP_SFS
    
    let ratePerHour = Overtime.ratePerHour(salary: salary,
                                           workingHours: workingHours,
                                           payFrequency: frequency)
    let overtimePay = Overtime.totalPay(hourlyRate: ratePerHour,
                                        hoursWorked: hoursWorked)
    
    let salaryAfterGovDeductionsAndOvertimePay = salaryAfterAFP_SFS + overtimePay.totalUnder68Hours + overtimePay.totalOver68Hours
    let ISRDeductionAmount = ISR.getMonthlyRetentionAmount(salaryAfterGovDeductionsAndOvertimePay)
    
    let netSalary = salary + overtimePay.totalUnder68Hours + overtimePay.totalOver68Hours - totalDeductions - ISRDeductionAmount
    
    return netSalary
  }
  
}
import Foundation

struct Payroll {
  
  static func calculateAFP_SFS(salary: NSDecimalNumber) -> NSDecimalNumber {
    let salaryAfterAFP_SFS = Deduction.applyGovernmentTaxes(toSalary: salary)
    return salaryAfterAFP_SFS
  }
  
  static func calculateMonthlyNetSalary(salary: NSDecimalNumber) -> NSDecimalNumber {
    let salaryAfterAFP_SFS = Deduction.applyGovernmentTaxes(toSalary: salary)
    let salaryISRDeductionAmount = ISR.getMonthlyRetentionAmount(salaryAfterAFP_SFS)
    let netSalary = salaryAfterAFP_SFS - salaryISRDeductionAmount
    
    return netSalary
  }
  
  static func calculateBiWeeklyNetSalary(salary: NSDecimalNumber) -> NSDecimalNumber {
    let calculateSalary = calculateMonthlyNetSalary(salary)
    return NSDecimalNumber.roundToNearestTwo(calculateSalary / 2)
  }
  
  static func netSalaryWithOvertimePay(salary salary: NSDecimalNumber, workingHours: NSDecimalNumber, hoursWorked: NSDecimalNumber, frequency: PaymentFrequency) -> NSDecimalNumber {
    
    let salaryAfterAFP_SFS = Deduction.applyGovernmentTaxes(toSalary: salary)
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
  
  static func obtainAllDeductions(forSalary salary: NSDecimalNumber) -> [String: NSDecimalNumber] {
    var allDeductions: [String: NSDecimalNumber] = [:]
    let afpDeduction = Deduction.calculateAFP(salary)
    let sfsDeduction = Deduction.calculateSFS(salary)
    let isrDeduction = ISR.getMonthlyRetentionAmount(calculateAFP_SFS(salary))
    
    allDeductions.updateValue(afpDeduction, forKey: "AFP")
    allDeductions.updateValue(sfsDeduction, forKey: "SFS")
    allDeductions.updateValue(isrDeduction, forKey: "ISR")
    
    return allDeductions
  }
  
  static func obtainAllEarnings(forSalary salary: NSDecimalNumber, hoursWorked hours: NSDecimalNumber) -> [String: NSDecimalNumber] {
    var allEarnings: [String: NSDecimalNumber] = [:]
    var netSalary = salary
    var extraHours: (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber)?
    let salaryAppliesForOvertime = Overtime.doesSalaryApplyForOvertimePay(salary, hoursWorked: hours)
    
    if salaryAppliesForOvertime {
      netSalary = netSalaryWithOvertimePay(salary: salary, workingHours: 8, hoursWorked: hours, frequency: PaymentFrequency.monthly)
      let hourlyRate = Overtime.ratePerHour(salary: salary, workingHours: 8, payFrequency: PaymentFrequency.monthly)
      extraHours = Overtime.totalPay(hourlyRate: hourlyRate, hoursWorked: hours)
      
      let totalOvertimePay = extraHours!.totalUnder68Hours + extraHours!.totalOver68Hours
      
      allEarnings.updateValue(totalOvertimePay, forKey: "Horas Extra")
    }
    
    allEarnings.updateValue(netSalary, forKey: "Salario")
    
    return allEarnings
  }
  
}

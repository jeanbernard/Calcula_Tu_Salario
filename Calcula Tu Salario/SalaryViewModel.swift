import Foundation

struct SalaryViewModel {
  
  var netSalary: NSDecimalNumber = 0.0
  var income: NSDecimalNumber = 0.0
  var deductions: [NSDecimalNumber] = []
  
  init(salary: NSDecimalNumber) {
    self.netSalary = Payroll.calculateMonthlyNetSalary(salary)
    self.income = salary
    self.deductions = calculateDeductions(salary)
  }
  
  init() {
    
  }
  
  private mutating func calculateDeductions(salary: NSDecimalNumber) -> [NSDecimalNumber] {
    deductions.append(Deduction.calculateAFP(salary))
    deductions.append(Deduction.calculateSFS(salary))
    return deductions
  }
  
}

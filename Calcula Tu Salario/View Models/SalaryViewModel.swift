import Foundation

struct SalaryViewModel {
  
  var netSalary: NSDecimalNumber = 0.0
  var income: NSDecimalNumber = 0.0
  var deductions: [String: NSDecimalNumber] = [:]
  
  init(salary: NSDecimalNumber) {
    self.netSalary = Payroll.calculateMonthlyNetSalary(salary)
    self.income = salary
    self.deductions = Deduction.obtainAll(forSalary: salary)
  }
  
  init() {
    
  }
}

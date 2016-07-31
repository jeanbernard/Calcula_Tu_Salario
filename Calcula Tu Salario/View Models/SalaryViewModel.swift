import Foundation

struct SalaryViewModel {
  
  var netSalary: String?
  var income: String?
  var deductions: [String: NSDecimalNumber] = [:]
  
  init(salary: NSDecimalNumber) {
    self.netSalary = "\(Payroll.calculateMonthlyNetSalary(salary))"
    self.income = "\(salary)"
    self.deductions = Payroll.obtainAllDeductions(forSalary: salary)
  }
  
  init() {
    
  }
  
  

}

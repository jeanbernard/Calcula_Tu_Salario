import Foundation

struct SalaryViewModel {
  
  var netSalary: String?
  var income: String?
  var deductions: [String: NSDecimalNumber] = [:]
  
  init(salary: NSDecimalNumber) {
    self.netSalary = formatNumberToCurrency(Payroll.calculateMonthlyNetSalary(salary))
    self.income = "\(salary)"
    self.deductions = Payroll.obtainAllDeductions(forSalary: salary)
  }
  
  init() {
    
  }
  
  private func formatNumberToCurrency(number: NSDecimalNumber) -> String? {
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    
    if let formattedNumber = formatter.stringFromNumber(number) {
      return formattedNumber
    }
    return nil
  }

}

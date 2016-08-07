import Foundation

struct SalaryViewModel {
  
  var viewNetSalary: String?
  var viewIncome: String?
  var viewDeductions: [String: String] = [:]
  
  init(salary: NSDecimalNumber) {
    let payroll = Payroll(withSalary: salary, frequency: PayrollFrequency.monthly)
    self.viewNetSalary = formatNumberToCurrencyString(payroll.netSalary)
    self.viewIncome = formatNumberToCurrencyString(salary)
    self.viewDeductions = formatDictionaryToCurrencyString(payroll.deductions)
  }
  
  init() {
    
  }
  
  private func formatNumberToCurrencyString(number: NSDecimalNumber) -> String? {
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    
    if let formattedNumber = formatter.stringFromNumber(number) {
      return formattedNumber
    }
    return nil
  }
  
  private func formatDictionaryToCurrencyString(dictionary: [String: NSDecimalNumber]) -> [String: String] {
    var stringyDictionary: [String: String] = [:]
    
    for (key, value) in dictionary {
      stringyDictionary.updateValue(formatNumberToCurrencyString(value)!, forKey: key)
    }
    return stringyDictionary
  }

}

import Foundation

struct SalaryViewModel {
  
  private var salary: NSDecimalNumber = 0.0
  private var payroll: Payroll = Payroll()
  private var shift: Bool = false
  private var customDeductions: [Deduction] = []
  
  var viewNetSalary: String? {
    get {
      return formatNumberToCurrencyString(payroll.netSalary)
    }
  }
  
  var viewIncome: [String: String] {
    get {
      return formatDictionaryToCurrencyString(payroll.incomes)
    }
  }
  
  var viewDeductions: [String: String] {
    get {
      return formatDictionaryToCurrencyString(payroll.deductions)
    }
  }
  
  init(salary: NSDecimalNumber, shift: Bool, customDeductions: [Deduction]) {
    self.salary = salary
    self.shift = shift
    self.customDeductions = customDeductions
    payroll = Payroll(withSalary: salary, andShift: shift, andDeductions: customDeductions)
  }
  
  init() {
    
  }
  
  mutating func showBiWeeklyResults() {
    payroll.calculateBiWeeklyPayroll()
  }
  
  mutating func showMonthlyResults() {
    payroll = Payroll(withSalary: salary, andShift: shift, andDeductions: customDeductions)
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

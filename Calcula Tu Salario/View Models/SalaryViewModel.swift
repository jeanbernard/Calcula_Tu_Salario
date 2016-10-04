import Foundation

struct SalaryViewModel {
  
  fileprivate var salary: NSDecimalNumber = 0.0
  fileprivate var payroll: Payroll = Payroll()
  fileprivate var shift: Bool = false
  fileprivate var customDeductions: [Deduction] = []
  fileprivate var customIncomes: [Income] = []
  
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
  
  init(salary: NSDecimalNumber, shift: Bool, customDeductions: [Deduction], customIncomes: [Income]) {
    self.salary = salary
    self.shift = shift
    self.customDeductions = customDeductions
    self.customIncomes = customIncomes
    payroll = Payroll(withSalary: salary, andShift: shift, andDeductions: customDeductions, andIncomes: customIncomes)
  }
  
  init() {
    
  }
  
  mutating func showBiWeeklyResults() {
    payroll.calculateBiWeeklyPayroll()
  }
  
  mutating func showMonthlyResults() {
    payroll = Payroll(withSalary: salary, andShift: shift, andDeductions: customDeductions, andIncomes: customIncomes)
  }
  
  fileprivate func formatNumberToCurrencyString(_ number: NSDecimalNumber) -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    
    if let formattedNumber = formatter.string(from: number) {
      return formattedNumber
    }
    return nil
  }
  
  
  fileprivate func formatDictionaryToCurrencyString(_ dictionary: [String: NSDecimalNumber]) -> [String: String] {
    var stringyDictionary: [String: String] = [:]
    
    for (key, value) in dictionary {
      stringyDictionary.updateValue(formatNumberToCurrencyString(value)!, forKey: key)
    }
    return stringyDictionary
  }
  
}

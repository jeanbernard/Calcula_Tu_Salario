import Foundation

struct SalaryViewModel {
  
  private var salary: NSDecimalNumber = 0.0
  private var payroll: Payroll = Payroll()
  
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
  
  init(salary: NSDecimalNumber) {
    self.salary = salary
    payroll = Payroll(withSalary: salary)
  }
  
  init(salary: NSDecimalNumber, andExtraHours extraHours: NSDecimalNumber) {
    self.salary = salary
    payroll = Payroll(withSalary: salary, andExtraHours: extraHours)
  }
  
  init() {
    
  }
  
  mutating func showBiWeeklyResults() {
    payroll.calculateBiWeeklyPayroll()
  }
  
  mutating func showMonthlyResults() {
    payroll = Payroll(withSalary: salary)
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

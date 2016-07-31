import Foundation

struct SalaryViewModel {
  
  var netSalary: String?
  var income: String?
  var deductions: [String: String] = [:]
  
  init(salary: NSDecimalNumber) {
    self.netSalary = formatNumberToCurrencyString(Payroll.calculateMonthlyNetSalary(salary))
    self.income = formatNumberToCurrencyString(salary)
    self.deductions = formatDictionaryToCurrencyString(Payroll.obtainAllDeductions(forSalary: salary))
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

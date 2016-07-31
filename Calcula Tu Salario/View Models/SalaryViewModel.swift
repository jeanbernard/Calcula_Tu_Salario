import Foundation

struct SalaryViewModel {
  
  var netSalary: String?
  var income: String?
  var deductions: [String: String] = [:]
  
  init(salary: NSDecimalNumber) {
    self.netSalary = formatNumberToCurrency(Payroll.calculateMonthlyNetSalary(salary))
    self.income = formatNumberToCurrency(salary)
    self.deductions = formatDictionaryToCurrency(Payroll.obtainAllDeductions(forSalary: salary))
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
  
  private func formatDictionaryToCurrency(dictionary: [String: NSDecimalNumber]) -> [String: String] {

    var stringyDictionary: [String: String] = [:]
    
    for (key, value) in dictionary {
      stringyDictionary.updateValue(formatNumberToCurrency(value)!, forKey: key)
    }
    return stringyDictionary
  }

}

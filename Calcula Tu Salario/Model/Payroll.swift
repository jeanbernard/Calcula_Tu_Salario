import Foundation

enum PayrollFrequency: NSDecimalNumber {
  case monthly = 1
  case biWeekly = 2
}

struct Payroll: Tax {
  
  var salary: NSDecimalNumber = 0.0
  var deductions: [String: NSDecimalNumber] = [:]
  var income: [String: NSDecimalNumber] = [:]
  var netSalary: NSDecimalNumber = 0.0
  var frequency: PayrollFrequency = .monthly
  
  init(withSalary salary: NSDecimalNumber, frequency: PayrollFrequency) {
    self.frequency = frequency
    self.deductions = obtainDeductions(forSalary: salary)
    self.income.updateValue(salary, forKey: "Salary")
    self.netSalary = calculateNet(salary: salary, deductions: deductions, frequency: frequency)
  }
  
  init() {
    
  }
  
  private func calculateNet(salary salary: NSDecimalNumber, deductions: [String: NSDecimalNumber],
                                   frequency: PayrollFrequency) -> NSDecimalNumber {
    
    var netSalary = salary
    
    for deduction in deductions.values {
      netSalary = netSalary - deduction
    }
    
    return calculatePayFrequency(forNetSalary: netSalary, withFrequency: frequency)
  }
  
  private func calculatePayFrequency(forNetSalary netSalary: NSDecimalNumber, withFrequency frequency: PayrollFrequency) -> NSDecimalNumber {
    
    switch frequency {
    case .monthly:
      return netSalary
    case .biWeekly:
      let biWeeklyNetSalary = NSDecimalNumber.roundToNearestTwo(netSalary / 2)
      return biWeeklyNetSalary
    }
    
  }
  
}


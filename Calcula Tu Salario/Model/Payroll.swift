import Foundation


struct Payroll: Tax {
  
  var salary: NSDecimalNumber = 0.0
  var deductions: [String: NSDecimalNumber] = [:]
  var income: [String: NSDecimalNumber] = [:]
  var netSalary: NSDecimalNumber = 0.0
  
  init(withSalary salary: NSDecimalNumber) {
    self.salary = salary
    self.deductions = obtainDeductions(forSalary: salary)
    self.income.updateValue(salary, forKey: "Salary")
    self.netSalary = calculateNet(salary: salary, deductions: deductions)
  }
  
  init() {
    
  }
  
  mutating func calculateBiWeeklyPayroll() {
    salary = NSDecimalNumber.roundToNearestTwo(salary / 2)
    netSalary = NSDecimalNumber.roundToNearestTwo(netSalary / 2)
    
    for (key, value) in deductions {
      deductions[key] = NSDecimalNumber.roundToNearestTwo(value / 2)
    }
    
    for (key, value) in income {
      income[key] = NSDecimalNumber.roundToNearestTwo(value / 2)
    }
    
  }
  
  private func calculateNet(salary salary: NSDecimalNumber, deductions: [String: NSDecimalNumber]) -> NSDecimalNumber {
    
    var netSalary = salary
    
    for deduction in deductions.values {
      netSalary = netSalary - deduction
    }
    
    return netSalary
  }
  
  
}


import Foundation


struct Payroll: Tax, Holiday, Overtime {
  
  var salary: NSDecimalNumber = 0.0
  var deductions: [String: NSDecimalNumber] = [:]
  var incomes: [String: NSDecimalNumber] = [:]
  var netSalary: NSDecimalNumber = 0.0
  var extraHours: NSDecimalNumber = 0.0
  
  init(withSalary salary: NSDecimalNumber) {
    self.salary = salary
    self.deductions = obtainDeductions(forSalary: salary)
    self.incomes.updateValue(salary, forKey: "Salario")
    calculateNet()
  }
  
  init(withSalary salary: NSDecimalNumber, andExtraHours extraHours:NSDecimalNumber) {
    self.salary = salary
    self.extraHours = extraHours
    self.deductions = obtainDeductions(forSalary: salary)
    self.incomes.updateValue(salary, forKey: "Salario")
    obtainExtraHoursIncome()
    overtimePayISRRetention()
    calculateNet()
  }
  
  init() {
    
  }
  
  mutating func calculateBiWeeklyPayroll() {
    salary = NSDecimalNumber.roundToNearestTwo(salary / 2)
    netSalary = NSDecimalNumber.roundToNearestTwo(netSalary / 2)
    
    for (key, value) in deductions {
      deductions[key] = NSDecimalNumber.roundToNearestTwo(value / 2)
    }
    
    for (key, value) in incomes {
      incomes[key] = NSDecimalNumber.roundToNearestTwo(value / 2)
    }
    
  }
  
  
  private mutating func calculateNet() {
    
    for income in incomes.values {
      netSalary = netSalary + income
    }
    
    for deduction in deductions.values {
      netSalary = netSalary - deduction
    }
    
  }
  
  private mutating func obtainExtraHoursIncome() {
    let hourlyRate = ratePerHour(salary: salary, workingHours: 8, payFrequency: .monthly)
    let extraTotal = totalPay(forHourlyRate: hourlyRate, andExtraHoursWorked: extraHours)
    let horasExtra = extraTotal.totalUnder68Hours + extraTotal.totalOver68Hours
    incomes.updateValue(horasExtra, forKey: "Horas Extra")
  }
  
  private mutating func overtimePayISRRetention() {
    let salaryAfterGovRetention = salary - deductions["AFP"]! - deductions["SFS"]!
    let salaryAfterAddingOvertimePay = salaryAfterGovRetention + incomes["Horas Extra"]!
    let isrRetention = getMonthlyRetentionAmount(salaryAfterAddingOvertimePay)
    deductions.updateValue(isrRetention, forKey: "ISR")
  }
  
  
  
}


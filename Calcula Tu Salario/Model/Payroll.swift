import Foundation


struct Payroll: Tax, Holiday, Overtime, NightShift {
  
  var salary: NSDecimalNumber = 0.0
  var deductions: [String: NSDecimalNumber] = [:]
  var incomes: [String: NSDecimalNumber] = [:]
  var netSalary: NSDecimalNumber = 0.0
  var shift: Bool = false
  var customDeductions: [Deduction] = []
  var customIncomes: [Income] = []
  
  init(withSalary salary: NSDecimalNumber, andShift shift: Bool, andDeductions customDeductions: [Deduction], andIncomes customIncomes: [Income]) {
    self.salary = salary
    self.shift = shift
    self.deductions = obtainDeductions(forSalary: salary)
    self.incomes.updateValue(salary, forKey: "Salario")
    
    if !customDeductions.isEmpty {
      for deduction in customDeductions {
        deductions.updateValue(deduction.amount, forKey: deduction.name)
      }
    }
    
    if !customIncomes.isEmpty {
      for income in customIncomes {
        incomes.updateValue(income.amount, forKey: income.name)
      }
    }
    
    if shift {
      calculateNightShift()
    }
    
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
  
  
  fileprivate mutating func calculateNet() {
    
    for income in incomes.values {
      netSalary = netSalary + income
    }
    
    for deduction in deductions.values {
      netSalary = netSalary - deduction
    }
    
  }
  
  fileprivate mutating func calculateNightShift() {
    let nightShiftRatePerHour = nightShiftRate(forSalary: salary)
    let nightShiftAmount = nightShiftTotalPay(forSalary: salary, andNightlyRate: nightShiftRatePerHour)
    incomes.updateValue(nightShiftAmount, forKey: "Horas Nocturnas")
    calculateNightShiftRetention()
  }
  
  fileprivate mutating func calculateNightShiftRetention() {
    var salaryAfterGovernmentRetention: NSDecimalNumber = 0.0
    var salaryAfterAddingNightPay: NSDecimalNumber = 0.0
    
    if let
      afpDeduction = deductions["AFP"],
      let sfsDeduction = deductions["SFS"],
      let nightShiftHours = incomes["Horas Nocturnas"]
    {
      salaryAfterGovernmentRetention = salary - afpDeduction - sfsDeduction
      salaryAfterAddingNightPay = salaryAfterGovernmentRetention + nightShiftHours
    }
    
    let isrRetention = getMonthlyRetentionAmount(salaryAfterAddingNightPay)
    deductions.updateValue(isrRetention, forKey: "ISR")
  }
  
}


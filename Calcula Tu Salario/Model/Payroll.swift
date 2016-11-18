import Foundation


struct Payroll: Taxable, Holiday, Overtime, NightShift {
  
  var salary: NSDecimalNumber = 0.0
  var netSalary: NSDecimalNumber = 0.0
  var shift: Bool = false
  var deductions: [Deduction] = []
  var incomes: [Income] = []
  
  init(withSalary salary: NSDecimalNumber, andShift shift: Bool, andDeductions deductions: [Deduction], andIncomes incomes: [Income]) {
    self.salary = salary
    self.shift = shift
    self.deductions = deductions + TaxFactory.calculateGovernmentTaxes(forSalary: salary)
    self.incomes = incomes + prepareSalaryIncome()
    getRetentionAmount()
    if shift {
      //calculateNightShift()
    }
    calculateNet()
  }
  
  init(){
    
  }
  
  fileprivate mutating func prepareSalaryIncome () -> [Income] {
    return [Income(name: "Salario", amount: salary, appliesForISR: true)]
  }
  
  fileprivate mutating func getRetentionAmount() {
    let ISRDeductions = deductions.filter { $0.appliesForISR }
    let ISRIncomes = incomes.filter { $0.appliesForISR }
    let amountSentToISR = ISRIncomes.reduce(0) { $0 + $1.amount } - ISRDeductions.reduce(0) { $0 + $1.amount }
    deductions.append(
      Deduction(name: "ISR",
                amount: getMonthlyRetentionAmount(amountSentToISR),
                percentage: getPercentage(self.salary),
                frequency: .monthly,
                type: .government,
                appliesForISR: false)
    )
  }
  
  fileprivate enum Tax: NSDecimalNumber {
    case AFP = 0.0287
    case SFS = 0.0304
  }
  
  //TaxFactory takes a salary and returns an array of deductions which include AFP and SFS.
  fileprivate enum TaxFactory {
    static func calculateGovernmentTaxes(forSalary salary: NSDecimalNumber) -> [Deduction] {
      let afpAmount = NSDecimalNumber.roundToNearestTwo(salary.multiplying(by: Tax.AFP.rawValue))
      let sfsAmount = NSDecimalNumber.roundToNearestTwo(salary.multiplying(by: Tax.SFS.rawValue))
      
      let afp = Deduction(name: "AFP", amount: afpAmount, percentage: Tax.AFP.rawValue, frequency: .monthly, type: .government, appliesForISR: true)
      let sfs = Deduction(name: "SFS", amount: sfsAmount, percentage: Tax.SFS.rawValue, frequency: .monthly, type: .government, appliesForISR: true)
      
      return [afp, sfs]
    }
  }
  
  mutating func calculateBiWeeklyPayroll() {
    netSalary = NSDecimalNumber.roundToNearestTwo(netSalary / 2)
    
    for (index, _) in deductions.enumerated() {
      _ = deductions[index].amount / 2
    }
    
    for (index, _) in incomes.enumerated() {
      _ = incomes[index].amount / 2
    }
  }
  
  fileprivate mutating func calculateNet() {
    netSalary = incomes.reduce(0) { $0 + $1.amount } - deductions.reduce(0) { $0 + $1.amount }
  }
  
  //  fileprivate mutating func calculateNightShift() {
  //    let nightShiftRatePerHour = nightShiftRate(forSalary: salary)
  //    let nightShiftAmount = nightShiftTotalPay(forSalary: salary, andNightlyRate: nightShiftRatePerHour)
  //    incomes.updateValue(nightShiftAmount, forKey: "Horas Nocturnas")
  //    calculateNightShiftRetention()
  //  }
  //
  //  fileprivate mutating func calculateNightShiftRetention() {
  //    var salaryAfterGovernmentRetention: NSDecimalNumber = 0.0
  //    var salaryAfterAddingNightPay: NSDecimalNumber = 0.0
  //
  //    if let
  //      afpDeduction = deductions["AFP"],
  //      let sfsDeduction = deductions["SFS"],
  //      let nightShiftHours = incomes["Horas Nocturnas"]
  //    {
  //      salaryAfterGovernmentRetention = salary - afpDeduction - sfsDeduction
  //      salaryAfterAddingNightPay = salaryAfterGovernmentRetention + nightShiftHours
  //    }
  //
  //    let isrRetention = getMonthlyRetentionAmount(salaryAfterAddingNightPay)
  //    deductions.updateValue(isrRetention, forKey: "ISR")
  //  }
  
}


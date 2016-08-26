import XCTest
@testable import Calcula_Tu_Salario

class PayrollTest: XCTestCase {
  
  func testExemptFromTaxesNetSalary() {
    let salary: NSDecimalNumber = 30_000
    let payroll = Payroll(withSalary: salary, andShift: false)
    let expectedNetSalary: NSDecimalNumber = 28_227
    let netSalaryExemptFromTaxes = payroll.netSalary
    XCTAssertEqual(expectedNetSalary, netSalaryExemptFromTaxes)
  }
  
  func test15PercentMonthlyNetSalary() {
    let salary: NSDecimalNumber = 50_400
    let payroll = Payroll(withSalary: salary, andShift: false)
    let expectedNetSalary: NSDecimalNumber = 45_424.17
    let netSalary = payroll.netSalary
    XCTAssertEqual(expectedNetSalary, netSalary)
  }

  func test15PercentBiWeeklyNetSalary() {
    let salary: NSDecimalNumber = 50_400
    var payroll = Payroll(withSalary: salary, andShift: false)
    let expectedNetSalary: NSDecimalNumber = 22_712.09
    payroll.calculateBiWeeklyPayroll()
    let netSalary = payroll.netSalary
    XCTAssertEqual(expectedNetSalary, netSalary)
  }

  func test15PercentBiWeeklyNetSalaryAfterOtherDeductions() {
    let coop: NSDecimalNumber = 6300
    let gym: NSDecimalNumber = 1097.5
    let salary: NSDecimalNumber = 50_400
    var payroll = Payroll(withSalary: salary, andShift: false)
    let expectedNetSalary: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(15_314.59)
    payroll.calculateBiWeeklyPayroll()
    let netSalary = payroll.netSalary
    let result = netSalary - coop - gym
    XCTAssertEqual(expectedNetSalary, result)
  }

  func test20PercentBiWeeklyNetSalary() {
    let salary: NSDecimalNumber = 60_000.00
    var payroll = Payroll(withSalary: salary, andShift: false)
    let expectedBiWeeklyNetSalary: NSDecimalNumber = 26_418.61
    payroll.calculateBiWeeklyPayroll()
    let biWeeklyNetSalary = payroll.netSalary
    
    XCTAssertEqual(expectedBiWeeklyNetSalary, biWeeklyNetSalary)
  }

  func test25PercentBiWeeklyNetSalary() {
    let salary: NSDecimalNumber = 80_000.00
    var payroll = Payroll(withSalary: salary, andShift: false)
    let expectedBiWeeklyNetSalary: NSDecimalNumber = 33_840.37
    payroll.calculateBiWeeklyPayroll()
    let biWeeklyNetSalary = payroll.netSalary
    
    XCTAssertEqual(expectedBiWeeklyNetSalary, biWeeklyNetSalary)
  }

  func testAllDeductions() {
    let salary: NSDecimalNumber = 50_400
    let payroll = Payroll(withSalary: salary, andShift: false)
    let expectedDeductions: [String: NSDecimalNumber] = [
      "AFP": 1446.48,
      "SFS": 1532.16,
      "ISR": 1997.19
    ]
    
    let deductions = payroll.deductions
    
    XCTAssertEqual(expectedDeductions, deductions)
  }
  
  func testNightShiftISRRetentionAmount() {
    let salary: NSDecimalNumber = 50_400
    let payroll = Payroll(withSalary: salary, andShift: true)
    let expectedRetentionAmount: NSDecimalNumber = 3_322.31
    let retentionAmount = payroll.deductions["ISR"]
    
    XCTAssertEqual(expectedRetentionAmount, retentionAmount)
  }
  
}


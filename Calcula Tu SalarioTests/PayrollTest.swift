import XCTest
@testable import Calcula_Tu_Salario

class PayrollTest: XCTestCase {
  
  func testExemptFromTaxesNetSalary() {
    let salary: NSDecimalNumber = 30_000
    let expectedNetSalary: NSDecimalNumber = 28_227
    let netSalaryExemptFromTaxes = Payroll.calculateAFP_SFS(salary)
    XCTAssertEqual(expectedNetSalary, netSalaryExemptFromTaxes)
  }
  
  func test15PercentMonthlyNetSalary() {
    let salary: NSDecimalNumber = 50_400
    let expectedNetSalary: NSDecimalNumber = 45_424.17
    let netSalary = Payroll.calculateMonthlyNetSalary(salary)
    XCTAssertEqual(expectedNetSalary, netSalary)
  }
  
  func test15PercentBiWeeklyNetSalary() {
    let salary: NSDecimalNumber = 50_400
    let expectedNetSalary: NSDecimalNumber = 22_712.09
    let netSalary = Payroll.calculateBiWeeklyNetSalary(salary)
    XCTAssertEqual(expectedNetSalary, netSalary)
  }
  
  func test15PercentBiWeeklyNetSalaryAfterOtherDeductions() {
    let coop: NSDecimalNumber = 6300
    let gym: NSDecimalNumber = 1097.5
    let salary: NSDecimalNumber = 50_400
    let expectedNetSalary: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(15_314.59)
    let netSalary = Payroll.calculateBiWeeklyNetSalary(salary)
    let result = netSalary - coop - gym
    XCTAssertEqual(expectedNetSalary, result)
  }
  
  func test20PercentBiWeeklyNetSalary() {
    let salary: NSDecimalNumber = 60_000.00
    let expectedBiWeeklyNetSalary: NSDecimalNumber = 26_418.61
    let biWeeklyNetSalary = Payroll.calculateBiWeeklyNetSalary(salary)
    
    XCTAssertEqual(expectedBiWeeklyNetSalary, biWeeklyNetSalary)
  }
  
  func test25PercentBiWeeklyNetSalary() {
    let salary: NSDecimalNumber = 80_000.00
    let expectedBiWeeklyNetSalary: NSDecimalNumber = 33_840.37
    let biWeeklyNetSalary = Payroll.calculateBiWeeklyNetSalary(salary)
    
    XCTAssertEqual(expectedBiWeeklyNetSalary, biWeeklyNetSalary)
  }
  
  func test15PercentBiWeeklyNetSalaryWithOvertimePay() {
    let salary: NSDecimalNumber = 50_400
    let hoursWorked: NSDecimalNumber = 65
    let workingHours: NSDecimalNumber = 8
    let payFrequency: PaymentFrequency = .monthly
    let expectedNetSalaryWithOvertimePay: NSDecimalNumber = 44_112.12
    
    let biWeeklyNetSalaryWithOvertimePay = Payroll.calculateMonthlyNetSalaryWithOvertimePay(salary: salary, workingHours: workingHours, hoursWorked: hoursWorked, payFrequency: payFrequency)
    
    XCTAssertEqual(expectedNetSalaryWithOvertimePay, biWeeklyNetSalaryWithOvertimePay)
    
  }
  
}

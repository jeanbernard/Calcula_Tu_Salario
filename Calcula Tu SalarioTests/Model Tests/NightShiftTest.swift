import XCTest
@testable import Calcula_Tu_Salario

class NightShiftTest: XCTestCase {
  
  var salary: NSDecimalNumber = 0.0
  var payroll: NightShift = Payroll()
  
  override func setUp() {
    super.setUp()
    salary = 10_000.00
  }
  
  func testNightShiftRatePerHour() {
    let expectedNightShiftRatePerHour: NSDecimalNumber = 60.32
    let nightShiftRatePerHour = payroll.nightShiftRate(forSalary: salary)
    
    XCTAssertEqual(expectedNightShiftRatePerHour, nightShiftRatePerHour)
  }
  
  func testNightShiftPayAmount() {
    let expectedNightShiftPay: NSDecimalNumber = 1_499.4
    let nightShiftPay = payroll.nightShiftTotalPay(forSalary: salary, andNightlyRate: 60.32)
    
    XCTAssertEqual(expectedNightShiftPay, nightShiftPay)
  }
  
  func testNightShiftPayAmountForHigherSalary() {
    let expectedNightShiftPay: NSDecimalNumber = 7_560.28
    let nightShiftPay = payroll.nightShiftTotalPay(forSalary: 50_400, andNightlyRate: 304.03)
    
    XCTAssertEqual(expectedNightShiftPay, nightShiftPay)
  }
  
}

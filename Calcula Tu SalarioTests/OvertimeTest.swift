import XCTest
@testable import Calcula_Tu_Salario

class OvertimeTest: XCTestCase {
  
  func testHourlyOvertimePayPerMonth() {
    let salary: NSDecimalNumber = 10_000.00
    let hoursWorked: NSDecimalNumber = 8
    let expectedHourlyOvertimePayPerMonth: NSDecimalNumber = 52.45
    let hourlyOvertimePayPerMonth = Overtime.calculateHourlyOvertimePayPerMonth(salary, hoursWorked: hoursWorked)
    XCTAssertEqual(expectedHourlyOvertimePayPerMonth, hourlyOvertimePayPerMonth)
  }
  
  
  
}
import XCTest
@testable import Calcula_Tu_Salario

class WageTest: XCTestCase {
  
  func testHourlyWagePerMonth() {
    let wage: NSDecimalNumber = 50200.00
    let hoursWorked: NSDecimalNumber = 8
    let expectedHourlyWagePerMonth: NSDecimalNumber = 263.32
    let hourlyWagePerMonth = Overtime.calculateHourlyWagePerMonth(wage, hoursWorked: hoursWorked)
    XCTAssertEqual(expectedHourlyWagePerMonth, hourlyWagePerMonth)
  }
  
  
  
}
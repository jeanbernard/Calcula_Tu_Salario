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
  
  func testHourlyOvertimePayPerBiWeek() {
    let salary: NSDecimalNumber = 10_000.00
    let hoursWorked: NSDecimalNumber = 8
    let expectedHourlyOvertimePayPerBiWeek: NSDecimalNumber = 104.95
    let hourlyOvertimePayPerBiWeek = Overtime.calculateHourlyOvertimePayPerBiWeekly(salary, hoursWorked: hoursWorked)
    XCTAssertEqual(expectedHourlyOvertimePayPerBiWeek, hourlyOvertimePayPerBiWeek)
  }
  
  func testHourlyOvertimePayPerWeek() {
    let salary: NSDecimalNumber = 10_000.00
    let hoursWorked: NSDecimalNumber = 8
    let expectedHourlyOvertimePayPerWeek: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(227.27)
    let hourlyOvertimePayPerBiWeek = Overtime.calculateHourlyOvertimePayPerWeek(salary, hoursWorked: hoursWorked)
    XCTAssertEqual(expectedHourlyOvertimePayPerWeek, hourlyOvertimePayPerBiWeek)
  }
  
}
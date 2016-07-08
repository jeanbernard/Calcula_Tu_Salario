import XCTest
@testable import Calcula_Tu_Salario

class OvertimeTest: XCTestCase {
  
  var salary: NSDecimalNumber = 0.0
  var hoursWorked: NSDecimalNumber = 0
  
  override func setUp() {
    super.setUp()
    salary = 10_000.00
    hoursWorked = 8
  }
  
  func testHourlyOvertimePayPerMonth() {
    let frequency: HourlyWage = .monthly
    let expectedHourlyWagePerMonth: NSDecimalNumber = 52.45
    
    let hourlyWagePerMonth = Overtime.hourlyWage(salary, normalWorkingHours: hoursWorked, frequency: frequency)
    
    XCTAssertEqual(expectedHourlyWagePerMonth, hourlyWagePerMonth)
  }
  
  func testHourlyOvertimePayPerBiWeek() {
    let frequency: HourlyWage = .biWeekly
    let expectedHourlyWagePerBiWeek: NSDecimalNumber = 104.95
    
    let hourlyWagePerBiWeek = Overtime.hourlyWage(salary, normalWorkingHours: hoursWorked, frequency: frequency)
    
    XCTAssertEqual(expectedHourlyWagePerBiWeek, hourlyWagePerBiWeek)
  }

  func testHourlyOvertimePayPerWeek() {
    let frequency: HourlyWage = .weekly
    let expectedHourlyWagePerWeek: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(227.27)
    
    let hourlyWagePerWeek = Overtime.hourlyWage(salary, normalWorkingHours: hoursWorked, frequency: frequency)
    
    XCTAssertEqual(expectedHourlyWagePerWeek, hourlyWagePerWeek)
  }
  
}
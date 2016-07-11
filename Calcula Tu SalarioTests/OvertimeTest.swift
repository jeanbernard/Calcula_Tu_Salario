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
  
  func testHourlyWagePerMonth() {
    let frequency: HourlyWage = .monthly
    let expectedHourlyWagePerMonth: NSDecimalNumber = 52.45
    
    let hourlyWagePerMonth = Overtime.hourlyWage(salary, normalWorkingHours: hoursWorked, frequency: frequency)
    
    XCTAssertEqual(expectedHourlyWagePerMonth, hourlyWagePerMonth)
  }
  
  func testHourlyWagePerBiWeek() {
    let frequency: HourlyWage = .biWeekly
    let expectedHourlyWagePerBiWeek: NSDecimalNumber = 104.95
    
    let hourlyWagePerBiWeek = Overtime.hourlyWage(salary, normalWorkingHours: hoursWorked, frequency: frequency)
    
    XCTAssertEqual(expectedHourlyWagePerBiWeek, hourlyWagePerBiWeek)
  }

  func testHourlyWagePerWeek() {
    let frequency: HourlyWage = .weekly
    let expectedHourlyWagePerWeek: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(227.27)
    
    let hourlyWagePerWeek = Overtime.hourlyWage(salary, normalWorkingHours: hoursWorked, frequency: frequency)
    
    XCTAssertEqual(expectedHourlyWagePerWeek, hourlyWagePerWeek)
  }
  
  func testAmountOfExtraHoursWorked() {
    let expectedExtraHoursAmount: NSDecimalNumber = 21
    hoursWorked = 65
    
    let extraHoursAmount = Overtime.extraHoursWorked(hoursWorked)
    
    XCTAssertEqual(expectedExtraHoursAmount, extraHoursAmount)
    
  }
  
  func testExtraAmountPerHour() {
    let expectedExtraHourAmount: NSDecimalNumber = 70.81
    let hourlyWagePerMonth: NSDecimalNumber = 52.45
    
    let extraHourAmount = Overtime.extraAmountPerHour(wage: hourlyWagePerMonth)
    
    XCTAssertEqual(expectedExtraHourAmount, extraHourAmount)
    
  }
  
  func testOvertimePay() {
    let expectedOvertimePay: NSDecimalNumber = 1_487.01
    hoursWorked = 21
    let extraAmountPerHour: NSDecimalNumber = 70.81
    let totalOvertimePay = Overtime.totalPay(extraHoursWorked: hoursWorked, extraHourAmount: extraAmountPerHour)
    XCTAssertEqual(expectedOvertimePay, totalOvertimePay)
  }
  
}
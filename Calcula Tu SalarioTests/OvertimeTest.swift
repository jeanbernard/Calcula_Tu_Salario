import XCTest
@testable import Calcula_Tu_Salario

class OvertimeTest: XCTestCase {
  
  var salary: NSDecimalNumber = 0.0
  var hoursWorked: NSDecimalNumber = 0
  var workingHours: NSDecimalNumber = 0
  var frequency: PaymentFrequency = .monthly
  
  override func setUp() {
    super.setUp()
    salary = 10_000.00
    hoursWorked = 44
    workingHours = 8
    frequency = .monthly
  }
  
  func testHourlyRatePerMonth() {
    let expectedRatePerMonth: NSDecimalNumber = 52.45
    let ratePerMonth = Overtime.ratePerHour(salary: salary, workingHours: workingHours, payFrequency: frequency)
    
    XCTAssertEqual(expectedRatePerMonth, ratePerMonth)
  }
  
  func testHourlyRatePerBiWeek() {
    frequency = .biWeekly
    let expectedRatePerBiWeek: NSDecimalNumber = 104.95
    let ratePerMonthPerBiWeek = Overtime.ratePerHour(salary: salary, workingHours: workingHours, payFrequency: frequency)
    
    XCTAssertEqual(expectedRatePerBiWeek, ratePerMonthPerBiWeek)
  }
  
  func testHourlyRatePerWeek() {
    frequency = .weekly
    let expectedRatePerWeek: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(227.27)
    let ratePerWeek = Overtime.ratePerHour(salary: salary, workingHours: workingHours, payFrequency: frequency)
    
    XCTAssertEqual(expectedRatePerWeek, ratePerWeek)
  }
  
  func testExtraHoursWorked90HourWorkWeek() {
    hoursWorked = 90
    let expectedAmountOfExtraHours: (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (24, 22)
    let amountOfExtraHoursWorked = Overtime.extraHoursWorked(total: hoursWorked)
    
    XCTAssertEqual(expectedAmountOfExtraHours.under68Hours,
                   amountOfExtraHoursWorked.under68Hours)
    
    XCTAssertEqual(expectedAmountOfExtraHours.over68Hours,
                   amountOfExtraHoursWorked.over68Hours)
  }
  
  func testExtraHoursWorked65HourWorkWeek() {
    hoursWorked = 65
    let expectedAmountOfExtraHours: (thiryFivePercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) = (21, 0)
    let amountOfExtraHoursWorked = Overtime.extraHoursWorked(total: hoursWorked)
    
    XCTAssertEqual(expectedAmountOfExtraHours.thiryFivePercent,
                   amountOfExtraHoursWorked.under68Hours)
    
    XCTAssertEqual(expectedAmountOfExtraHours.hundredPercent,
                   amountOfExtraHoursWorked.over68Hours)
  }
  
  func testExtraHourlyRate90HourWorkWeek() {
    hoursWorked = 90
    let hourlyRate: NSDecimalNumber = 52.45
    let expectedExtraHourlyRate: (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (70.81, 104.90)
    
    let extraHourlyRate = Overtime.extraRatePerHour(rate: hourlyRate, hoursWorked: hoursWorked)
    
    XCTAssertEqual(expectedExtraHourlyRate.under68Hours,
                   extraHourlyRate.under68Hours)
    
    XCTAssertEqual(expectedExtraHourlyRate.over68Hours,
                   extraHourlyRate.over68Hours)
  }
  
  func testExtraHourlyRate65HourWorkWeek() {
    hoursWorked = 65
    let hourlyRate: NSDecimalNumber = 52.45
    let expectedExtraHourlyRate:
      (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (70.81, 0)
    
    let extraHourlyRate = Overtime.extraRatePerHour(rate: hourlyRate, hoursWorked: hoursWorked)
    
    XCTAssertEqual(expectedExtraHourlyRate.under68Hours,
                   extraHourlyRate.under68Hours)
    
    XCTAssertEqual(expectedExtraHourlyRate.over68Hours,
                   extraHourlyRate.over68Hours)
  }
  
  func testOvertimePay90HourWorkWeek() {
    hoursWorked = 90
    let extraHourlyRate: (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (70.81, 104.90)
    let expectedOvertimePay: (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) = (1_699.44, 2_307.80)
    let overtimePay = Overtime.payPerPercentage(hoursWorked: hoursWorked, hourlyRateUnder68Hours: extraHourlyRate.under68Hours, hourlyRateOver68Hours: extraHourlyRate.over68Hours)
    
    XCTAssertEqual(expectedOvertimePay.totalUnder68Hours,
                   overtimePay.totalUnder68Hours)
    
    XCTAssertEqual(expectedOvertimePay.totalOver68Hours,
                   overtimePay.totalOver68Hours)
  }
  
  func testOvertimePay65HourWorkWeek() {
    hoursWorked = 65
    let extraHourlyRate: (thirtyFivePercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) = (70.81, 0)
    let expectedOvertimePay: (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) = (1_487.01, 0)
    //let expectedOvertimePay: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(4_007.24)
    
    let overtimePay = Overtime.payPerPercentage(hoursWorked: hoursWorked, hourlyRateUnder68Hours: extraHourlyRate.thirtyFivePercent, hourlyRateOver68Hours: extraHourlyRate.hundredPercent)
    
    XCTAssertEqual(expectedOvertimePay.totalUnder68Hours,
                   overtimePay.totalUnder68Hours)
    
    XCTAssertEqual(expectedOvertimePay.totalOver68Hours,
                   overtimePay.totalOver68Hours)
  }
  
  
}
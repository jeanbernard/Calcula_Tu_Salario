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
  
  func testRatePerMonth() {
    let frequency: PaymentFrequency = .monthly
    let expectedRatePerMonth: NSDecimalNumber = 52.45
    
    let ratePerMonth = Overtime.ratePerHour(salary, normalWorkingHours: hoursWorked, payFrequency: frequency)
    
    XCTAssertEqual(expectedRatePerMonth, ratePerMonth)
  }
  
  func testRatePerBiWeek() {
    let frequency: PaymentFrequency = .biWeekly
    let expectedRatePerBiWeek: NSDecimalNumber = 104.95
    
    let ratePerMonthPerBiWeek = Overtime.ratePerHour(salary, normalWorkingHours: hoursWorked, payFrequency: frequency)
    
    XCTAssertEqual(expectedRatePerBiWeek, ratePerMonthPerBiWeek)
  }
  
  func testRatePerWeek() {
    let frequency: PaymentFrequency = .weekly
    let expectedRatePerWeek: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(227.27)
    
    let ratePerWeek = Overtime.ratePerHour(salary, normalWorkingHours: hoursWorked, payFrequency: frequency)
    
    XCTAssertEqual(expectedRatePerWeek, ratePerWeek)
  }
  
  func testAmountOfExtraHoursWorked90HourWorkWeek() {
    hoursWorked = 90
    let expectedAmountOfExtraHours: (thiryFivePercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) = (24, 22)
    let amountOfExtraHoursWorked = Overtime.amountOfExtraHoursWorked(hoursWorked)
    
    XCTAssertEqual(expectedAmountOfExtraHours.thiryFivePercent, amountOfExtraHoursWorked.thiryFivePercent)
    XCTAssertEqual(expectedAmountOfExtraHours.hundredPercent, amountOfExtraHoursWorked.hundredPercent)
  }
  
  func testAmountOfExtraHoursWorked65HourWorkWeek() {
    hoursWorked = 65
    let expectedAmountOfExtraHours: (thiryFivePercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) = (21, 0)
    let amountOfExtraHoursWorked = Overtime.amountOfExtraHoursWorked(hoursWorked)
    
    XCTAssertEqual(expectedAmountOfExtraHours.thiryFivePercent, amountOfExtraHoursWorked.thiryFivePercent)
    XCTAssertEqual(expectedAmountOfExtraHours.hundredPercent, amountOfExtraHoursWorked.hundredPercent)
  }
  
  func testExtraHourlyRate90HourWorkWeek() {
    hoursWorked = 90
    let hourlyRate: NSDecimalNumber = 52.45
    let expectedExtraHourlyRate:
      (thiryPercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) = (70.81, 104.90)
    
    let extraHourlyRate = Overtime.extraRatePerHour(rate: hourlyRate, hoursWorked: hoursWorked)
    
    XCTAssertEqual(expectedExtraHourlyRate.thiryPercent, extraHourlyRate.thirtyPercent)
    XCTAssertEqual(expectedExtraHourlyRate.hundredPercent, extraHourlyRate.hundredPercent)
    
  }
  
  func testExtraHourlyRate65HourWorkWeek() {
    hoursWorked = 65
    let hourlyRate: NSDecimalNumber = 52.45
    let expectedExtraHourlyRate:
      (thiryPercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) = (70.81, 0)
    
    let extraHourlyRate = Overtime.extraRatePerHour(rate: hourlyRate, hoursWorked: hoursWorked)
    
    XCTAssertEqual(expectedExtraHourlyRate.thiryPercent, extraHourlyRate.thirtyPercent)
    XCTAssertEqual(expectedExtraHourlyRate.hundredPercent, extraHourlyRate.hundredPercent)
    
  }
  
  func testOvertimePay90HourWorkWeek() {
    hoursWorked = 90
    let extraHourlyRate: (thirtyFivePercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) = (70.81, 104.90)
    let expectedOvertimePay: (totalAtThirtyPercent: NSDecimalNumber, totalAtHundredPercent: NSDecimalNumber) = (1_699.44, 2_307.80)    
    let overtimePay = Overtime.payPerPercentage(hoursWorked: hoursWorked, hourlyRateThirtyFivePercent: extraHourlyRate.thirtyFivePercent, hourlyRateHundredPercent: extraHourlyRate.hundredPercent)
    
    XCTAssertEqual(expectedOvertimePay.totalAtThirtyPercent, overtimePay.totalAtThirtyPercent)
    XCTAssertEqual(expectedOvertimePay.totalAtHundredPercent, overtimePay.totalAtHundredPercent)
    
  }
  
  func testOvertimePay65HourWorkWeek() {
    hoursWorked = 65
    let extraHourlyRate: (thirtyFivePercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) = (70.81, 0)
    let expectedOvertimePay: (totalAtThirtyPercent: NSDecimalNumber, totalAtHundredPercent: NSDecimalNumber) = (1_487.01, 0)
    //let expectedOvertimePay: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(4_007.24)
    
    let overtimePay = Overtime.payPerPercentage(hoursWorked: hoursWorked, hourlyRateThirtyFivePercent: extraHourlyRate.thirtyFivePercent, hourlyRateHundredPercent: extraHourlyRate.hundredPercent)
    
    XCTAssertEqual(expectedOvertimePay.totalAtThirtyPercent, overtimePay.totalAtThirtyPercent)
    XCTAssertEqual(expectedOvertimePay.totalAtHundredPercent, overtimePay.totalAtHundredPercent)
    
  }
  
  
}
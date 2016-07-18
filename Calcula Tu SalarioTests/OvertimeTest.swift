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
    let expectedExtraHours: (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (24, 22)
    let extraHoursWorked = Overtime.extraHoursWorked(hours: hoursWorked)
    
    XCTAssertEqual(expectedExtraHours.under68Hours,
                   extraHoursWorked.under68Hours)
    
    XCTAssertEqual(expectedExtraHours.over68Hours,
                   extraHoursWorked.over68Hours)
  }
  
  func testExtraHoursWorked65HourWorkWeek() {
    hoursWorked = 65
    let expectedExtraHours: (thiryFivePercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) = (21, 0)
    let extraHoursWorked = Overtime.extraHoursWorked(hours: hoursWorked)
    
    XCTAssertEqual(expectedExtraHours.thiryFivePercent,
                   extraHoursWorked.under68Hours)
    
    XCTAssertEqual(expectedExtraHours.hundredPercent,
                   extraHoursWorked.over68Hours)
  }
  
  func testExtraHourlyRate90HourWorkWeek() {
    hoursWorked = 90
    let hourlyRate: NSDecimalNumber = 52.45
    let expectedExtraHourlyRate: (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (70.81, 104.90)
    
    let extraHourlyRate = Overtime.extraRatePerHour(hourlyRate: hourlyRate, hoursWorked: hoursWorked)
    
    XCTAssertEqual(expectedExtraHourlyRate.under68Hours,
                   extraHourlyRate.under68Hours)
    
    XCTAssertEqual(expectedExtraHourlyRate.over68Hours,
                   extraHourlyRate.over68Hours)
  }
  
  func testExtraHourlyRate65HourWorkWeek() {
    hoursWorked = 65
    let normalHourlyRate: NSDecimalNumber = 52.45
    let expectedExtraHourlyRate:
      (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (70.81, 0)
    
    let extraHourlyRate = Overtime.extraRatePerHour(hourlyRate: normalHourlyRate, hoursWorked: hoursWorked)
    
    XCTAssertEqual(expectedExtraHourlyRate.under68Hours,
                   extraHourlyRate.under68Hours)
    
    XCTAssertEqual(expectedExtraHourlyRate.over68Hours,
                   extraHourlyRate.over68Hours)
  }
  
  func testOvertimePay90HourWorkWeek() {
    hoursWorked = 90
    let normalHourlyRate: NSDecimalNumber = 52.45
    let expectedOvertimePay: (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) = (1_699.44, 2_307.80)
    let overtimePay = Overtime.totalPay(hourlyRate: normalHourlyRate, hoursWorked: hoursWorked)
    
    XCTAssertEqual(expectedOvertimePay.totalUnder68Hours,
                   overtimePay.totalUnder68Hours)
    
    XCTAssertEqual(expectedOvertimePay.totalOver68Hours,
                   overtimePay.totalOver68Hours)
  }
  
  func testOvertimePay65HourWorkWeek() {
    hoursWorked = 65
    let normalHourlyRate: NSDecimalNumber = 52.45
    let expectedOvertimePay: (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) = (1_487.01, 0)
    let overtimePay = Overtime.totalPay(hourlyRate: normalHourlyRate, hoursWorked: hoursWorked)
    
    XCTAssertEqual(expectedOvertimePay.totalUnder68Hours,
                   overtimePay.totalUnder68Hours)
    
    XCTAssertEqual(expectedOvertimePay.totalOver68Hours,
                   overtimePay.totalOver68Hours)
  }
  
  func testNightShiftRate() {
    let expectedNightShiftRate: NSDecimalNumber = 60.32
    let nightShiftRate = Overtime.nightShiftRate(salary: salary, workingNightHours: workingHours, payFrequency: frequency)
    
    XCTAssertEqual(expectedNightShiftRate, nightShiftRate)
  }
  
  func testOvertimePayNightShift() {
    let expectedOvertimePayNightShift: NSDecimalNumber = 1_499.40
    let overtimePayNightShift = Overtime.nightShiftTotalPay(salary: salary, workingNightHours: workingHours, payFrequency: frequency)
    
    XCTAssertEqual(expectedOvertimePayNightShift, overtimePayNightShift)
  }
  
}
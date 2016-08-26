import XCTest
@testable import Calcula_Tu_Salario

class OvertimeTest: XCTestCase {
  
  var salary: NSDecimalNumber = 0.0
  var hoursWorked: NSDecimalNumber = 0
  var workingHours: NSDecimalNumber = 0
  var frequency: PaymentFrequency = .monthly
  let payroll: Overtime = Payroll()
  
  override func setUp() {
    super.setUp()
    salary = 10_000.00
    hoursWorked = 44
    workingHours = 8
    frequency = .monthly
    
  }
  
  func testIfSalaryAppliesForOvertimePay() {
    let extraHours: NSDecimalNumber = 29
    let doesSalaryApplyForOvertimePay = payroll.doesSalaryApplyForOvertimePay(extraHours: extraHours)
    
    XCTAssertTrue(doesSalaryApplyForOvertimePay)
  }
  
  func testIfSalaryDoesNotApplyForOvertimePay() {
    let extraHours: NSDecimalNumber = 0
    let doesSalaryApplyForOvertimePay = payroll.doesSalaryApplyForOvertimePay(extraHours: extraHours)
    
    XCTAssertFalse(doesSalaryApplyForOvertimePay)
  }
  
  func testHourlyRatePerMonth() {
    let expectedRatePerMonth: NSDecimalNumber = 52.45
    let ratePerMonth = payroll.ratePerHour(salary: salary, workingHours: workingHours, payFrequency: frequency)
    
    XCTAssertEqual(expectedRatePerMonth, ratePerMonth)
  }
  
  func testHourlyRatePerBiWeek() {
    frequency = .biWeekly
    let expectedRatePerBiWeek: NSDecimalNumber = 104.95
    let ratePerMonthPerBiWeek = payroll.ratePerHour(salary: salary, workingHours: workingHours, payFrequency: frequency)
    
    XCTAssertEqual(expectedRatePerBiWeek, ratePerMonthPerBiWeek)
  }
  
  func testHourlyRatePerWeek() {
    frequency = .weekly
    let expectedRatePerWeek: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(227.27)
    let ratePerWeek = payroll.ratePerHour(salary: salary, workingHours: workingHours, payFrequency: frequency)
    
    XCTAssertEqual(expectedRatePerWeek, ratePerWeek)
  }
  
  func testExtraHoursWorked90HourWorkWeek() {
    let extraHours: NSDecimalNumber = 46
    let expectedExtraHours: (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (24, 22)
    let extraHoursWorked = payroll.extraHoursWorked(hours: extraHours)
    
    XCTAssertEqual(expectedExtraHours.under68Hours,
                   extraHoursWorked.under68Hours)
    
    XCTAssertEqual(expectedExtraHours.over68Hours,
                   extraHoursWorked.over68Hours)
  }
  
  func testExtraHoursWorked65HourWorkWeek() {
    let extraHours: NSDecimalNumber = 21
    let expectedExtraHours: (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (21, 0)
    let extraHoursWorked = payroll.extraHoursWorked(hours: extraHours)
    
    XCTAssertEqual(expectedExtraHours.under68Hours,
                   extraHoursWorked.under68Hours)
    
    XCTAssertEqual(expectedExtraHours.over68Hours,
                   extraHoursWorked.over68Hours)
  }
  
  func testExtraHoursWorked44HourWorkWeek() {
    let extraHours: NSDecimalNumber = 0
    let expectedExtraHours: (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (0, 0)
    let extraHoursWorked = payroll.extraHoursWorked(hours: extraHours)
    
    XCTAssertEqual(expectedExtraHours.under68Hours,
                   extraHoursWorked.under68Hours)
    
    XCTAssertEqual(expectedExtraHours.over68Hours,
                   extraHoursWorked.over68Hours)
  }
  
  func testExtraHourlyRate90HourWorkWeek() {
    let hourlyRate: NSDecimalNumber = 52.45
    let extraHours: NSDecimalNumber = 46
    let expectedExtraHourlyRate: (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (70.81, 104.90)
    
    let extraHourlyRate = payroll.extraRatePerHour(rate: hourlyRate, extraHours: extraHours)
    
    XCTAssertEqual(expectedExtraHourlyRate.under68Hours,
                   extraHourlyRate.under68Hours)
    
    XCTAssertEqual(expectedExtraHourlyRate.over68Hours,
                   extraHourlyRate.over68Hours)
  }
  
  func testExtraHourlyRate65HourWorkWeek() {
    let normalHourlyRate: NSDecimalNumber = 52.45
    let extraHours: NSDecimalNumber = 21
    let expectedExtraHourlyRate:
      (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) = (70.81, 0)
    
    let extraHourlyRate = payroll.extraRatePerHour(rate: normalHourlyRate, extraHours: extraHours)
    
    XCTAssertEqual(expectedExtraHourlyRate.under68Hours,
                   extraHourlyRate.under68Hours)
    
    XCTAssertEqual(expectedExtraHourlyRate.over68Hours,
                   extraHourlyRate.over68Hours)
  }
  
  func testTotalExtraHoursWorked() {
    let extraHours: NSDecimalNumber = 21
    let expectedTotalExtraHours: NSDecimalNumber = 65
    
    let totalExtraHours = payroll.totalExtraHoursWorked(forHours: extraHours)
    
    XCTAssertEqual(expectedTotalExtraHours, totalExtraHours)
  }
  
  
  func testOvertimePay90HourWorkWeek() {
    let extraHours: NSDecimalNumber = 46
    let normalHourlyRate: NSDecimalNumber = 52.45
    let expectedOvertimePay: (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) = (1_699.44, 2_307.80)
    let overtimePay = payroll.totalPay(forHourlyRate: normalHourlyRate, andExtraHoursWorked: extraHours)
    
    XCTAssertEqual(expectedOvertimePay.totalUnder68Hours,
                   overtimePay.totalUnder68Hours)
    
    XCTAssertEqual(expectedOvertimePay.totalOver68Hours,
                   overtimePay.totalOver68Hours)
  }
  
  func testOvertimePay65HourWorkWeek() {
    let extraHours: NSDecimalNumber = 21
    let normalHourlyRate: NSDecimalNumber = 52.45
    let expectedOvertimePay: (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) = (1_487.01, 0)
    let overtimePay = payroll.totalPay(forHourlyRate: normalHourlyRate, andExtraHoursWorked: extraHours)
    
    XCTAssertEqual(expectedOvertimePay.totalUnder68Hours,
                   overtimePay.totalUnder68Hours)
    
    XCTAssertEqual(expectedOvertimePay.totalOver68Hours,
                   overtimePay.totalOver68Hours)
  }
  
  func testOvertimePay68HourWorkWeek() {
    let extraHours: NSDecimalNumber = 24
    let normalHourlyRate: NSDecimalNumber = 264.37
    let expectedOvertimePay: (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) = (8_565.6, 0)
    let overtimePay = payroll.totalPay(forHourlyRate: normalHourlyRate, andExtraHoursWorked: extraHours)

    XCTAssertEqual(expectedOvertimePay.totalUnder68Hours,
                   overtimePay.totalUnder68Hours)
    
    XCTAssertEqual(expectedOvertimePay.totalOver68Hours,
                   overtimePay.totalOver68Hours)
    
  }
  
  func testOvertimePay69HourWorkWeek() {
    let extraHours: NSDecimalNumber = 25
    let normalHourlyRate: NSDecimalNumber = 264.37
    let expectedOvertimePay: (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) = (8_565.6, 528.74)
    let overtimePay = payroll.totalPay(forHourlyRate: normalHourlyRate, andExtraHoursWorked: extraHours)
    
    XCTAssertEqual(expectedOvertimePay.totalUnder68Hours,
                   overtimePay.totalUnder68Hours)
    
    XCTAssertEqual(expectedOvertimePay.totalOver68Hours,
                   overtimePay.totalOver68Hours)
    
  }
  
}
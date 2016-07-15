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
  
  func testPaymentFrequencyPerMonth() {
    let frequency: PaymentFrequency = .monthly
    let expectedPaymentFrequencyPerMonth: NSDecimalNumber = 52.45
    
    let PaymentFrequencyPerMonth = Overtime.hourlyWage(salary, normalWorkingHours: hoursWorked, payFrequency: frequency)
    
    XCTAssertEqual(expectedPaymentFrequencyPerMonth, PaymentFrequencyPerMonth)
  }
  
  func testPaymentFrequencyPerBiWeek() {
    let frequency: PaymentFrequency = .biWeekly
    let expectedPaymentFrequencyPerBiWeek: NSDecimalNumber = 104.95
    
    let PaymentFrequencyPerBiWeek = Overtime.hourlyWage(salary, normalWorkingHours: hoursWorked, payFrequency: frequency)
    
    XCTAssertEqual(expectedPaymentFrequencyPerBiWeek, PaymentFrequencyPerBiWeek)
  }
  
  func testPaymentFrequencyPerWeek() {
    let frequency: PaymentFrequency = .weekly
    let expectedPaymentFrequencyPerWeek: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(227.27)
    
    let PaymentFrequencyPerWeek = Overtime.hourlyWage(salary, normalWorkingHours: hoursWorked, payFrequency: frequency)
    
    XCTAssertEqual(expectedPaymentFrequencyPerWeek, PaymentFrequencyPerWeek)
  }
  
  func testAmountOfExtraHoursWorked90HourWorkWeek() {
    hoursWorked = 90
    let expectedAmountOfExtraHours: (hundredPercent: NSDecimalNumber, thiryFivePercent: NSDecimalNumber) = (22, 24)
    let amountOfExtraHoursWorked = Overtime.amountOfExtraHoursWorked(hoursWorked)
    
    XCTAssertEqual(expectedAmountOfExtraHours.hundredPercent, amountOfExtraHoursWorked.hundredPercent)
    XCTAssertEqual(expectedAmountOfExtraHours.thiryFivePercent, amountOfExtraHoursWorked.thiryFivePercent)
  }
  
  func testAmountOfExtraHoursWorked65HourWorkWeek() {
    hoursWorked = 65
    let expectedAmountOfExtraHours: (hundredPercent: NSDecimalNumber, thiryFivePercent: NSDecimalNumber) = (0, 21)
    let amountOfExtraHoursWorked = Overtime.amountOfExtraHoursWorked(hoursWorked)
    
    XCTAssertEqual(expectedAmountOfExtraHours.hundredPercent, amountOfExtraHoursWorked.hundredPercent)
    XCTAssertEqual(expectedAmountOfExtraHours.thiryFivePercent, amountOfExtraHoursWorked.thiryFivePercent)
  }
  
  func testExtraAmountPerHour() {
    let expectedExtraHourAmount: NSDecimalNumber = 70.81
    let extraHourAmount = Overtime.extraHourlyWage(salary, normalWorkingHours: 8, frequency: PaymentFrequency.monthly)
    
    XCTAssertEqual(expectedExtraHourAmount, extraHourAmount)
    
  }
  
//  func testOvertimePay() {
//    let expectedOvertimePay: NSDecimalNumber = 1_487.01
//    hoursWorked = 65
//    let totalOvertimePay = Overtime.totalPay(salary, normalWorkingHours: 8, totalHoursWorked: hoursWorked, payFrequency: PaymentFrequency.monthly)
//    
//    XCTAssertEqual(expectedOvertimePay, totalOvertimePay)
//  }
  
  
}
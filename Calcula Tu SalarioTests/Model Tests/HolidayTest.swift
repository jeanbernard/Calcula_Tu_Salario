import XCTest
@testable import Calcula_Tu_Salario

class HolidayTest: XCTestCase {
  
  func testHolidayPayAmount() {
    let payroll: Holiday = Payroll()
    let hourlyRate: NSDecimalNumber = 52.45
    let holidayHours: NSDecimalNumber = 8
    let expectedHolidayHourPay: NSDecimalNumber = 839.2
    let holidayHoursPay = payroll.holidayTotalPay(forHourlyRate: hourlyRate, andHolidayHours: holidayHours)
    
    XCTAssertEqual(expectedHolidayHourPay, holidayHoursPay)
  }

  
}
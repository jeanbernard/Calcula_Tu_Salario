import XCTest
@testable import Calcula_Tu_Salario

class TaxTest: XCTestCase {
  
  var salary: NSDecimalNumber = 50_400.00
  var payroll = Payroll()
  
  func testTaxDeductions() {
    let expectedTaxDeductions: [String: NSDecimalNumber] = [
      "AFP": 1446.48,
      "SFS": 1532.16,
      "ISR": 1997.19
    ]
    
    let taxDeductions = payroll.obtainDeductions(forSalary: salary)
    
    XCTAssertEqual(expectedTaxDeductions, taxDeductions)
  }
  
}

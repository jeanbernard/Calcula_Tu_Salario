import XCTest
@testable import Calcula_Tu_Salario

class SalaryViewModelTest: XCTestCase {

  func testNetSalaryResult() {
    let salary: NSDecimalNumber = 50_400.00
    let expectedNetResult: NSDecimalNumber = 45_424.17
    
    let netResult = SalaryViewModel.init(salary: salary)
    
    XCTAssertEqual(expectedNetResult, netResult.netSalary)
    
  }
  
}

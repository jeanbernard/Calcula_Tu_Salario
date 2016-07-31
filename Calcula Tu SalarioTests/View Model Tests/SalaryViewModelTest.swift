import XCTest
@testable import Calcula_Tu_Salario

class SalaryViewModelTest: XCTestCase {
  
  let salary: NSDecimalNumber = 50_400.00

  func testNetSalaryResult() {
    let expectedNetResult = "45424.17"
    let netResult = SalaryViewModel.init(salary: salary)
    
    XCTAssertEqual(expectedNetResult, netResult.netSalary)
  }
  
  func testDeductionsResult() {
    let expectedAFPDeduction: NSDecimalNumber = 1446.48
    let expectedSFSDeduction: NSDecimalNumber = 1532.16
    let salaryViewModelDeductions = SalaryViewModel.init(salary: salary)
    
    XCTAssertEqual(expectedAFPDeduction, salaryViewModelDeductions.deductions["AFP"])
    XCTAssertEqual(expectedSFSDeduction, salaryViewModelDeductions.deductions["SFS"])
  }
  
}

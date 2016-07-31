import XCTest
@testable import Calcula_Tu_Salario

class SalaryViewModelTest: XCTestCase {
  
  let salary: NSDecimalNumber = 50_400.00

  func testNetSalaryResult() {
    let expectedNetResult = "$45,424.17"
    let netResult = SalaryViewModel(salary: salary)
    
    XCTAssertEqual(expectedNetResult, netResult.netSalary)
  }
  
  func testDeductionsResult() {
    let expectedAFPDeduction: NSDecimalNumber = 1446.48
    let expectedSFSDeduction: NSDecimalNumber = 1532.16
    let expectedISR: NSDecimalNumber = 1997.19

    let salaryViewModelDeductions = SalaryViewModel(salary: salary)
    
    XCTAssertEqual(expectedAFPDeduction,
                   salaryViewModelDeductions.deductions["AFP"])
    XCTAssertEqual(expectedSFSDeduction,
                   salaryViewModelDeductions.deductions["SFS"])
    XCTAssertEqual(expectedISR,
                   salaryViewModelDeductions.deductions["ISR"])

  }
  
}

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
    let expectedAFPDeduction = "$1,446.48"
    let expectedSFSDeduction = "$1,532.16"
    let expectedISR = "$1,997.19"

    let salaryViewModelDeductions = SalaryViewModel(salary: salary)
    
    XCTAssertEqual(expectedAFPDeduction,
                   salaryViewModelDeductions.deductions["AFP"])
    XCTAssertEqual(expectedSFSDeduction,
                   salaryViewModelDeductions.deductions["SFS"])
    XCTAssertEqual(expectedISR,
                   salaryViewModelDeductions.deductions["ISR"])

  }
  
}

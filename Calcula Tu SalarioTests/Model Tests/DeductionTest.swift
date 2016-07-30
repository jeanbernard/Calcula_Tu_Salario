import XCTest
@testable import Calcula_Tu_Salario

class DeductionTest: XCTestCase {
  
  var salary: NSDecimalNumber = 0.0
  
  override func setUp() {
    super.setUp()
    salary = 50400.00
  }
  
  
  func testAFPDeduction() {
    let expectedAFPDeduction: NSDecimalNumber = 1446.48
    let afpDeduction = Deduction.calculateAFP(salary)
    XCTAssertEqual(expectedAFPDeduction, afpDeduction)
  }
  
  func testSFSDeduction() {
    let expectedSFSDeduction: NSDecimalNumber = 1532.16
    let sfsDeduction = Deduction.calculateSFS(salary)
    XCTAssertEqual(expectedSFSDeduction, sfsDeduction)
  }
  
  func testSalaryAfterApplyingAFP_SFS() {
    let expectedSalaryAfterGovernmentTaxes = 47421.36
    let totalSalaryAfterGovernmentTaxes = Deduction.applyGovernmentTaxes(toSalary: salary)
    XCTAssertEqual(expectedSalaryAfterGovernmentTaxes, totalSalaryAfterGovernmentTaxes)
  }
  
  func testObtainAllDeductions() {
    let expectedDeductions: [String: NSDecimalNumber] = ["AFP": 1446.48, "SFS": 1532.16]
    let deductions = Deduction.obtainAll(forSalary: salary)
    
    XCTAssertEqual(expectedDeductions, deductions)
  }
  
}

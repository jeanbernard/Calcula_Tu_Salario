import XCTest
@testable import Calcula_Tu_Salario

class DeductionTest: XCTestCase {
  
  var salary = 0.0
  
  override func setUp() {
    super.setUp()
    salary = 50400.00
  }
  
  
  func testAFPDeduction() {
    let expectedAFPDeduction = 1446.48
    let deduction = Deduction.TaxDeductions.AFP.rawValue
    let afpDeduction = salary * deduction
    XCTAssertEqual(expectedAFPDeduction, afpDeduction)
  }
  
  func testSFSDeduction() {
    let expectedSFSDeduction = 1532.16
    let deduction = Deduction.TaxDeductions.SFS.rawValue
    let sfsDeduction = salary * deduction
    XCTAssertEqual(expectedSFSDeduction, sfsDeduction)
  }
  
//  func testCustomDeduction() {
//    let expectedNetSalary = 49000.00
//    let customDeduction = Deduction(name: "Gym", amount: 1000.00)
//    let netSalary = salary - customDeduction.amount
//    XCTAssertEqual(expectedNetSalary, netSalary)
//  }
  
  func testSalaryAfterApplyingAFP_SFS() {
    let expectedSalaryAfterGovernmentTaxes = 47421.00
    let totalSalaryAfterGovernmentTaxes = Deduction.applyGovernmentTaxesToSalary(salary)
    XCTAssertEqual(expectedSalaryAfterGovernmentTaxes, totalSalaryAfterGovernmentTaxes)
  }
  
  
  
}

import XCTest
@testable import Calcula_Tu_Salario

class SalaryViewModelTest: XCTestCase {
  
  let salary: NSDecimalNumber = 50_400.00
  let customDeductions: [Deduction] = []
  let customIncomes: [Income] = []
  
  func testNotNil() {
    let salaryViewModel = SalaryViewModel()
    XCTAssertNotNil(salaryViewModel)
  }
  
  func testNetSalaryResult() {
    let expectedNetResult = "$45,424.17"
    let netResult = SalaryViewModel(salary: salary, shift: false, customDeductions: customDeductions, customIncomes: customIncomes)
    
    XCTAssertEqual(expectedNetResult, netResult.viewNetSalary)
  }
  
  func testDeductionsResult() {
    let expectedAFPDeduction = "$1,446.48"
    let expectedSFSDeduction = "$1,532.16"
    let expectedISR = "$1,997.19"
    
    let salaryViewModelDeductions = SalaryViewModel(salary: salary, shift: false, customDeductions: customDeductions, customIncomes: customIncomes)
    
    XCTAssertEqual(expectedAFPDeduction,
                   salaryViewModelDeductions.viewDeductions["AFP"])
    XCTAssertEqual(expectedSFSDeduction,
                   salaryViewModelDeductions.viewDeductions["SFS"])
    XCTAssertEqual(expectedISR,
                   salaryViewModelDeductions.viewDeductions["ISR"])
    
  }
  
  func testBiWeeklyResult() {
    let expectedIncome = "$25,200.00"
    let expectedNetResult = "$22,712.09"
    let expectedAFPDeduction = "$723.24"
    let expectedSFSDeduction = "$766.08"
    let expectedISR = "$998.60"
    
    var salaryViewModel = SalaryViewModel(salary: salary, shift: false, customDeductions: customDeductions, customIncomes: customIncomes)
    salaryViewModel.showBiWeeklyResults()
    
    XCTAssertEqual(expectedIncome,
                   salaryViewModel.viewIncome["Salario"])
    XCTAssertEqual(expectedNetResult,
                   salaryViewModel.viewNetSalary)
    XCTAssertEqual(expectedAFPDeduction,
                   salaryViewModel.viewDeductions["AFP"])
    XCTAssertEqual(expectedSFSDeduction,
                   salaryViewModel.viewDeductions["SFS"])
    XCTAssertEqual(expectedISR,
                   salaryViewModel.viewDeductions["ISR"])
    
  }
  
  func testShowMonthlyNetResult() {
    let expectedIncome = "$50,400.00"
    let expectedNetResult = "$45,424.17"
    let expectedAFPDeduction = "$1,446.48"
    let expectedSFSDeduction = "$1,532.16"
    let expectedISR = "$1,997.19"
    
    var salaryViewModel = SalaryViewModel(salary: salary, shift: false, customDeductions: customDeductions, customIncomes: customIncomes)
    salaryViewModel.showMonthlyResults()
    
    XCTAssertEqual(expectedIncome,
                   salaryViewModel.viewIncome["Salario"])
    XCTAssertEqual(expectedNetResult,
                   salaryViewModel.viewNetSalary)
    XCTAssertEqual(expectedAFPDeduction,
                   salaryViewModel.viewDeductions["AFP"])
    XCTAssertEqual(expectedSFSDeduction,
                   salaryViewModel.viewDeductions["SFS"])
    XCTAssertEqual(expectedISR,
                   salaryViewModel.viewDeductions["ISR"])
    
  }
  
}

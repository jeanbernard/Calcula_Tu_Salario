//import XCTest
//@testable import Calcula_Tu_Salario
//
//class PayrollTest: XCTestCase {
//  
//  func testExemptFromTaxesNetSalary() {
//    let salary: NSDecimalNumber = 30_000
//    let expectedNetSalary: NSDecimalNumber = 28_227
//    let netSalaryExemptFromTaxes = Payroll.calculateAFP_SFS(salary)
//    XCTAssertEqual(expectedNetSalary, netSalaryExemptFromTaxes)
//  }
//  
//  func test15PercentMonthlyNetSalary() {
//    let salary: NSDecimalNumber = 50_400
//    let expectedNetSalary: NSDecimalNumber = 45_424.17
//    let netSalary = Payroll.calculateMonthlyNetSalary(salary)
//    XCTAssertEqual(expectedNetSalary, netSalary)
//  }
//  
//  func test15PercentBiWeeklyNetSalary() {
//    let salary: NSDecimalNumber = 50_400
//    let expectedNetSalary: NSDecimalNumber = 22_712.09
//    let netSalary = Payroll.calculateBiWeeklyNetSalary(salary)
//    XCTAssertEqual(expectedNetSalary, netSalary)
//  }
//  
//  func test15PercentBiWeeklyNetSalaryAfterOtherDeductions() {
//    //FIXME: Check this test in the future.
//    let coop: NSDecimalNumber = 6300
//    let gym: NSDecimalNumber = 1097.5
//    let salary: NSDecimalNumber = 50_400
//    let expectedNetSalary: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(15_314.59)
//    let netSalary = Payroll.calculateBiWeeklyNetSalary(salary)
//    let result = netSalary.decimalNumberBySubtracting(coop).decimalNumberBySubtracting(gym)
//    XCTAssertEqual(expectedNetSalary, result)
//  }
//  
//  func test20PercentNetSalary() {
//    
//  }
//  
//  func test25PercentNetSalary() {
//    
//  }
//  
//}
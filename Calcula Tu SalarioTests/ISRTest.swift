import XCTest
@testable import Calcula_Tu_Salario

class ISRTest: XCTestCase {
  
  var noScaleSalary: NSDecimalNumber = 0.0
  var firstScaleSalary: NSDecimalNumber = 0.0
  var secondScaleSalary: NSDecimalNumber = 0.0
  var thirdScaleSalary: NSDecimalNumber = 0.0
  
  override func setUp() {
    super.setUp()
    noScaleSalary = 30000.00
    firstScaleSalary = 50400.00
    secondScaleSalary = 60000.00
    thirdScaleSalary = 80000.00
  }
  
  
  func testNetSalaryDoesNotApplyForISR() {
    let isSalaryISRFree = ISR.isSalaryExemptFromISR(noScaleSalary)
    XCTAssertTrue(isSalaryISRFree)
  }
  
  func testIfNetSalaryAppliesForISR() {
    let isSalaryISRFree = ISR.isSalaryExemptFromISR(firstScaleSalary)
    XCTAssertFalse(isSalaryISRFree)
  }

  func testSalaryAppliesFor15PercentISR() {
    let expectedISRPercent = 0.15
    let ISRPercent = ISR.getPercentage(firstScaleSalary)
    XCTAssertEqual(expectedISRPercent, ISRPercent)
  }

  func testSalaryAppliesFor20PercentISR() {
    let expectedISRPercent = 0.20
    let ISRPercent = ISR.getPercentage(secondScaleSalary)
    XCTAssertEqual(expectedISRPercent, ISRPercent)
    
  }

  func testSalaryAppliesFor25PercentISR() {
    let expectedISRPercent = 0.25
    let ISRPercent = ISR.getPercentage(thirdScaleSalary)
    XCTAssertEqual(expectedISRPercent, ISRPercent)
  }
//
//  func testISRSurplus15Percent() {
//    let expectedSurplus = 409_281.01
//    let surplusAmount = ISR.getSurplus(firstScaleSalary)
//    XCTAssertEqual(expectedSurplus, surplusAmount)
//  }
//  
//  func testISRSurplus20Percent() {
//    let expectedSurplus = 613_921.01
//    let surplusAmount = ISR.getSurplus(secondScaleSalary)
//    XCTAssertEqual(expectedSurplus, surplusAmount)
//  }
//  
//  func testISRSurplus25Percent() {
//    let expectedSurplus = 852_667.01
//    let surplusAmount = ISR.getSurplus(thirdScaleSalary)
//    XCTAssertEqual(expectedSurplus, surplusAmount)
//  }
//  
//  func testSalaryDoesNotApplyForISRRate() {
//    let expectedRateNumber = 0.0
//    let ISRPercent = 0.15
//    let rateNumber = ISR.getRateNumber(ISRPercent)
//    XCTAssertEqual(expectedRateNumber, rateNumber)
//  }
//  
//  func testISRRateNumber20Percent() {
//    let expectedRateNumber = 30_696.00
//    let ISRPercent = 0.20
//    let rateNumber = ISR.getRateNumber(ISRPercent)
//    XCTAssertEqual(expectedRateNumber, rateNumber)
//  }
//  
//  func testISRRateNumber25Percent() {
//    let expectedRateNumber = 78_446.00
//    let ISRPercent = 0.25
//    let rateNumber = ISR.getRateNumber(ISRPercent)
//    XCTAssertEqual(expectedRateNumber, rateNumber)
//  }
//  
//  func testISRYearlyRetentionAmount15Percent() {
//    let expectedYearlyISRRetentionAmount = 29_327.85
//    let ISRDeductionAmount = ISR.getYearlyRetentionAmount(firstScaleSalary)
//    XCTAssertEqual(expectedYearlyISRRetentionAmount, ISRDeductionAmount)
//  }
//  
//  func testISRYearlyRetentionAmount20Percent() {
//    let expectedYearlyISRRetentionAmount = 51_911.80
//    let ISRDeductionAmount = ISR.getYearlyRetentionAmount(secondScaleSalary)
//    XCTAssertEqual(expectedYearlyISRRetentionAmount, ISRDeductionAmount)
//  }
//  
//  func testISRYearlyRetentionAmount25Percent() {
//    let expectedYearlyISRRetentionAmount = 105_279.25
//    let ISRDeductionAmount = ISR.getYearlyRetentionAmount(thirdScaleSalary)
//    XCTAssertEqual(expectedYearlyISRRetentionAmount, ISRDeductionAmount)
//  }
//  
//  func testISRMontlyRetentionAmount15Percent() {
//    let expectedISRRetention = 2443.99
//    let ISRDeductionAmount = ISR.getMontlyRetentionAmount(firstScaleSalary)
//    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
//  }
//  
//  func testISRMonthlyRetentionAmount20Percent() {
//    let expectedISRRetention = 4325.98
//    let ISRDeductionAmount = ISR.getMontlyRetentionAmount(secondScaleSalary)
//    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
//  }
//  
//  func testISRMontlyRetentionAmount25Percent() {
//    let expectedISRRetention = 8773.27
//    let ISRDeductionAmount = ISR.getMontlyRetentionAmount(thirdScaleSalary)
//    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
//  }
//  
//  func testISRBiWeeklyRetentionAmount15Percent() {
//    let expectedISRRetention = 1221.995
//    let ISRDeductionAmount = ISR.getBiWeeklyRetentionAmount(firstScaleSalary)
//    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
//  }
//  
//  func testISRBiWeeklyRetentionAmount20Percent() {
//    let expectedISRRetention = 2162.99
//    let ISRDeductionAmount = ISR.getBiWeeklyRetentionAmount(secondScaleSalary)
//    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
//  }
  
//  func testISRBiWeeklyRetentionAmount25Percent() {
//    let expectedISRRetention = 4386.64
//    let ISRDeductionAmount = ISR.getBiWeeklyRetentionAmount(thirdScaleSalary)
//    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
//  }
  
  
}
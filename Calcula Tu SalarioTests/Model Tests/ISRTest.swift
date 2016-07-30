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
    firstScaleSalary = 47421.36
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
    let expectedISRPercent: NSDecimalNumber = 0.15
    let ISRPercent = ISR.getPercentage(firstScaleSalary)
    XCTAssertEqual(expectedISRPercent, ISRPercent)
  }

  func testSalaryAppliesFor20PercentISR() {
    let expectedISRPercent: NSDecimalNumber = 0.20
    let ISRPercent = ISR.getPercentage(secondScaleSalary)
    XCTAssertEqual(expectedISRPercent, ISRPercent)
    
  }

  func testSalaryAppliesFor25PercentISR() {
    let expectedISRPercent: NSDecimalNumber = 0.25
    let ISRPercent = ISR.getPercentage(thirdScaleSalary)
    XCTAssertEqual(expectedISRPercent, ISRPercent)
  }

  func testISRSurplus15Percent() {
    let expectedSurplus: NSDecimalNumber = 409_281.01
    let surplusAmount = ISR.getSurplus(firstScaleSalary)
    XCTAssertEqual(expectedSurplus, surplusAmount)
  }

  func testISRSurplus20Percent() {
    let expectedSurplus: NSDecimalNumber = 613_921.01
    let surplusAmount = ISR.getSurplus(secondScaleSalary)
    XCTAssertEqual(expectedSurplus, surplusAmount)
  }

  func testISRSurplus25Percent() {
    let expectedSurplus: NSDecimalNumber = 852_667.01
    let surplusAmount = ISR.getSurplus(thirdScaleSalary)
    XCTAssertEqual(expectedSurplus, surplusAmount)
  }

  func testSalaryDoesNotApplyForISRRate() {
    let expectedRateNumber: NSDecimalNumber = 0.0
    let ISRPercent: NSDecimalNumber = 0.15
    let rateNumber = ISR.getRateNumber(ISRPercent)
    XCTAssertEqual(expectedRateNumber, rateNumber)
  }

  func testISRRateNumber20Percent() {
    let expectedRateNumber: NSDecimalNumber = 30_696.00
    let ISRPercent: NSDecimalNumber = 0.20
    let rateNumber = ISR.getRateNumber(ISRPercent)
    XCTAssertEqual(expectedRateNumber, rateNumber)
  }
  
  func testISRRateNumber25Percent() {
    let expectedRateNumber: NSDecimalNumber = 78_446.00
    let ISRPercent: NSDecimalNumber = 0.25
    let rateNumber = ISR.getRateNumber(ISRPercent)
    XCTAssertEqual(expectedRateNumber, rateNumber)
  }

  func testISRYearlyRetentionAmount15Percent() {
    let expectedYearlyISRRetentionAmount: NSDecimalNumber = 23_966.3
    let ISRDeductionAmount = ISR.getYearlyRetentionAmount(firstScaleSalary)
    XCTAssertEqual(expectedYearlyISRRetentionAmount, ISRDeductionAmount)
  }

  func testISRYearlyRetentionAmount20Percent() {
    let expectedYearlyISRRetentionAmount: NSDecimalNumber = 51_911.80
    let ISRDeductionAmount = ISR.getYearlyRetentionAmount(secondScaleSalary)
    XCTAssertEqual(expectedYearlyISRRetentionAmount, ISRDeductionAmount)
  }

  func testISRYearlyRetentionAmount25Percent() {
    let expectedYearlyISRRetentionAmount = 105_279.25
    let ISRDeductionAmount = ISR.getYearlyRetentionAmount(thirdScaleSalary)
    XCTAssertEqual(expectedYearlyISRRetentionAmount, ISRDeductionAmount)
  }

  func testISRMontlyRetentionAmount15Percent() {
    let expectedISRRetention: NSDecimalNumber = 1997.19
    let ISRDeductionAmount = ISR.getMonthlyRetentionAmount(firstScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }

  func testISRMonthlyRetentionAmount20Percent() {
    let expectedISRRetention: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(4325.98)
    let ISRDeductionAmount = ISR.getMonthlyRetentionAmount(secondScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }

  func testISRMontlyRetentionAmount25Percent() {
    let expectedISRRetention: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(8773.27)
    let ISRDeductionAmount = ISR.getMonthlyRetentionAmount(thirdScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }
  
  func testISRBiWeeklyRetentionAmount15Percent() {
    let expectedISRRetention: NSDecimalNumber = 998.60
    let ISRDeductionAmount = ISR.getBiWeeklyRetentionAmount(firstScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }

  func testISRBiWeeklyRetentionAmount20Percent() {
    let expectedISRRetention: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(2162.99)
    let ISRDeductionAmount = ISR.getBiWeeklyRetentionAmount(secondScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }
  
  func testISRBiWeeklyRetentionAmount25Percent() {
    let expectedISRRetention: NSDecimalNumber = 4386.64
    let ISRDeductionAmount = ISR.getBiWeeklyRetentionAmount(thirdScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }
  
  
}
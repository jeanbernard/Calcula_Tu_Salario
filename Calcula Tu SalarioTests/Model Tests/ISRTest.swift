import XCTest
@testable import Calcula_Tu_Salario

class ISRTest: XCTestCase {
  
  var noScaleSalary: NSDecimalNumber = 30000.00
  var firstScaleSalary: NSDecimalNumber = 47421.36
  var secondScaleSalary: NSDecimalNumber = 60000.00
  var thirdScaleSalary: NSDecimalNumber = 80000.00
  var payroll = Payroll()
  
  func testNetSalaryDoesNotApplyForISR() {
    let isSalaryISRFree = payroll.isSalaryExemptFromISR(noScaleSalary)
    let netSalary = payroll.getYearlyRetentionAmount(10000.00)
    XCTAssertTrue(isSalaryISRFree)
    XCTAssertEqual(0, netSalary)
  }
  
  func testIfNetSalaryAppliesForISR() {
    let isSalaryISRFree = payroll.isSalaryExemptFromISR(firstScaleSalary)
    XCTAssertFalse(isSalaryISRFree)
  }
  
  func testSalaryAppliesFor15PercentISR() {
    let expectedISRPercent: NSDecimalNumber = 0.15
    let ISRPercent = payroll.getPercentage(firstScaleSalary)
    XCTAssertEqual(expectedISRPercent, ISRPercent)
  }

  func testSalaryAppliesFor20PercentISR() {
    let expectedISRPercent: NSDecimalNumber = 0.20
    let ISRPercent = payroll.getPercentage(secondScaleSalary)
    XCTAssertEqual(expectedISRPercent, ISRPercent)
    
  }

  func testSalaryAppliesFor25PercentISR() {
    let expectedISRPercent: NSDecimalNumber = 0.25
    let ISRPercent = payroll.getPercentage(thirdScaleSalary)
    XCTAssertEqual(expectedISRPercent, ISRPercent)
  }

  func testISRSurplus15Percent() {
    let expectedSurplus: NSDecimalNumber = 409_281.01
    let surplusAmount = payroll.getSurplus(firstScaleSalary)
    XCTAssertEqual(expectedSurplus, surplusAmount)
  }

  func testISRSurplus20Percent() {
    let expectedSurplus: NSDecimalNumber = 613_921.01
    let surplusAmount = payroll.getSurplus(secondScaleSalary)
    XCTAssertEqual(expectedSurplus, surplusAmount)
  }

  func testISRSurplus25Percent() {
    let expectedSurplus: NSDecimalNumber = 852_667.01
    let surplusAmount = payroll.getSurplus(thirdScaleSalary)
    XCTAssertEqual(expectedSurplus, surplusAmount)
  }

  func testSalaryDoesNotApplyForISRRate() {
    let expectedRateNumber: NSDecimalNumber = 0.0
    let ISRPercent: NSDecimalNumber = 0.15
    let rateNumber = payroll.getRateNumber(ISRPercent)
    XCTAssertEqual(expectedRateNumber, rateNumber)
  }

  func testISRRateNumber20Percent() {
    let expectedRateNumber: NSDecimalNumber = 30_696.00
    let ISRPercent: NSDecimalNumber = 0.20
    let rateNumber = payroll.getRateNumber(ISRPercent)
    XCTAssertEqual(expectedRateNumber, rateNumber)
  }
  
  func testISRRateNumber25Percent() {
    let expectedRateNumber: NSDecimalNumber = 78_446.00
    let ISRPercent: NSDecimalNumber = 0.25
    let rateNumber = payroll.getRateNumber(ISRPercent)
    XCTAssertEqual(expectedRateNumber, rateNumber)
  }

  func testISRYearlyRetentionAmount15Percent() {
    let expectedYearlyISRRetentionAmount: NSDecimalNumber = 23_966.3
    let ISRDeductionAmount = payroll.getYearlyRetentionAmount(firstScaleSalary)
    XCTAssertEqual(expectedYearlyISRRetentionAmount, ISRDeductionAmount)
  }

  func testISRYearlyRetentionAmount20Percent() {
    let expectedYearlyISRRetentionAmount: NSDecimalNumber = 51_911.80
    let ISRDeductionAmount = payroll.getYearlyRetentionAmount(secondScaleSalary)
    XCTAssertEqual(expectedYearlyISRRetentionAmount, ISRDeductionAmount)
  }

  func testISRYearlyRetentionAmount25Percent() {
    let expectedYearlyISRRetentionAmount = 105_279.25
    let ISRDeductionAmount = payroll.getYearlyRetentionAmount(thirdScaleSalary)
    XCTAssertEqual(expectedYearlyISRRetentionAmount, ISRDeductionAmount)
  }

  func testISRMontlyRetentionAmount15Percent() {
    let expectedISRRetention: NSDecimalNumber = 1997.19
    let ISRDeductionAmount = payroll.getMonthlyRetentionAmount(firstScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }

  func testISRMonthlyRetentionAmount20Percent() {
    let expectedISRRetention: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(4325.98)
    let ISRDeductionAmount = payroll.getMonthlyRetentionAmount(secondScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }

  func testISRMontlyRetentionAmount25Percent() {
    let expectedISRRetention: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(8773.27)
    let ISRDeductionAmount = payroll.getMonthlyRetentionAmount(thirdScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }
  
  func testISRBiWeeklyRetentionAmount15Percent() {
    let expectedISRRetention: NSDecimalNumber = 998.60
    let ISRDeductionAmount = payroll.getBiWeeklyRetentionAmount(firstScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }

  func testISRBiWeeklyRetentionAmount20Percent() {
    let expectedISRRetention: NSDecimalNumber = NSDecimalNumber.roundToNearestTwo(2162.99)
    let ISRDeductionAmount = payroll.getBiWeeklyRetentionAmount(secondScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }
  
  func testISRBiWeeklyRetentionAmount25Percent() {
    let expectedISRRetention: NSDecimalNumber = 4386.64
    let ISRDeductionAmount = payroll.getBiWeeklyRetentionAmount(thirdScaleSalary)
    XCTAssertEqual(expectedISRRetention, ISRDeductionAmount)
  }
  
  
}
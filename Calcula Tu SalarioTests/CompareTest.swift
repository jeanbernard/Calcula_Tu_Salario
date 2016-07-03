import XCTest
@testable import Calcula_Tu_Salario

class CompareTest: XCTestCase {
  
  func testGreaterThan() {
    let lowerNumber: NSDecimalNumber = 409_281.01
    let higherNumber: NSDecimalNumber = 613_921.00
    XCTAssertFalse(NSDecimalNumber.isGreaterThan(lowerNumber, higherNumber))
  }

  func testLessThan() {
    let lowerNumber: NSDecimalNumber = 409_281.01
    let higherNumber: NSDecimalNumber = 613_921.00
    XCTAssertTrue(NSDecimalNumber.isLessThan(lowerNumber, higherNumber))
  }

  func testIsEqualTo() {
    let number: NSDecimalNumber = 409_281.01
    let sameNumber: NSDecimalNumber = 409_281.01
    XCTAssertTrue(NSDecimalNumber.isEqualTo(number, sameNumber))
  }

  func testEqualityFails() {
    let number: NSDecimalNumber = 400
    let notSameNumber: NSDecimalNumber = 7
    XCTAssertFalse(NSDecimalNumber.isEqualTo(number, notSameNumber))
  }
  
}
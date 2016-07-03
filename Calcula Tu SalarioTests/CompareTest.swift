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
    XCTAssertTrue(NSDecimalNumber.isEqualTo(number, number))
  }

  func testEqualityFails() {
    let number: NSDecimalNumber = 400
    let notSameNumber: NSDecimalNumber = 7
    XCTAssertFalse(NSDecimalNumber.isEqualTo(number, notSameNumber))
  }
  
  func testGreaterThanOrEqualToIsTrue() {
    let number: NSDecimalNumber = 7
    XCTAssertTrue(NSDecimalNumber.isGreaterThanOrEqualTo(number, number))
  }
  
  func testGreaterThanOrEqualToIsFalse() {
    let number: NSDecimalNumber = 7
    let notSameNumber: NSDecimalNumber = 8
    XCTAssertFalse(NSDecimalNumber.isGreaterThanOrEqualTo(number, notSameNumber))
  }
  
  func testLessThanOrEqualToIsTrue() {
    let number: NSDecimalNumber = 7
    XCTAssertTrue(NSDecimalNumber.isLessThanOrEqualTo(number, number))
  }
  
  func testLessThanOrEqualToIsFalse() {
    let number: NSDecimalNumber = 9
    let notSameNumber: NSDecimalNumber = 8
    XCTAssertFalse(NSDecimalNumber.isLessThanOrEqualTo(number, notSameNumber))
  }
  
}
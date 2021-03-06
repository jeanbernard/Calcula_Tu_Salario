import XCTest
@testable import Calcula_Tu_Salario

class CompareTest: XCTestCase {
  
  func testGreaterThan() {
    let lowerNumber: NSDecimalNumber = 409_281.01
    let higherNumber: NSDecimalNumber = 613_921.00
    XCTAssertFalse(lowerNumber > higherNumber)
  }

  func testLessThan() {
    let lowerNumber: NSDecimalNumber = 409_281.01
    let higherNumber: NSDecimalNumber = 613_921.00
    XCTAssertTrue(lowerNumber < higherNumber)
  }

  func testIsEqualTo() {
    let number: NSDecimalNumber = 409_281.01
    XCTAssertTrue(number == number)
  }

  func testEqualityFails() {
    let number: NSDecimalNumber = 400
    let notSameNumber: NSDecimalNumber = 7
    XCTAssertFalse(number == notSameNumber)
  }
  
  func testGreaterThanOrEqualToIsTrue() {
    let number: NSDecimalNumber = 7
    XCTAssertTrue(number >= number)
  }

  func testGreaterThanOrEqualToIsFalse() {
    let number: NSDecimalNumber = 7
    let notSameNumber: NSDecimalNumber = 8
    XCTAssertFalse(number >= notSameNumber)
  }

  func testLessThanOrEqualToIsTrue() {
    let number: NSDecimalNumber = 7
    XCTAssertTrue(number <= number)
  }

  func testLessThanOrEqualToIsFalse() {
    let number: NSDecimalNumber = 9
    let notSameNumber: NSDecimalNumber = 8
    XCTAssertFalse(number <= notSameNumber)
  }
  
  func testSameNumberIsFalse() {
    let number: NSDecimalNumber = 44
    let sameNumber: NSDecimalNumber = 44
    XCTAssertFalse(number > sameNumber)
  }
  
}
//
//  Util.swift
//  Calcula Tu Salario
//
//  Created by Jean Bernard on 7/1/16.
//  Copyright © 2016 Jean Bernard. All rights reserved.
//

import Foundation

extension Double {
  static func roundToNearestTwo(number: Double) -> Double {
    return round(100 * number) / 100
  }
}

extension NSDecimalNumber {
  static func isGreaterThan(lhs: NSDecimalNumber, _ rhs: NSDecimalNumber) -> Bool {
    if lhs.compare(rhs).rawValue == -1 {
      return false
    }
    return true
  }
  
  static func isLessThan(lhs: NSDecimalNumber, _ rhs: NSDecimalNumber) -> Bool {
    if lhs.compare(rhs).rawValue == 1 {
      return false
    }
    return true
  }
  
  static func isEqualTo(lhs: NSDecimalNumber, _ rhs: NSDecimalNumber) -> Bool {
    if lhs.compare(rhs).rawValue == 0 {
      return true
    }
    return false
  }
  
  static func isGreaterThanOrEqualTo(lhs: NSDecimalNumber, _ rhs: NSDecimalNumber) -> Bool {
    if isGreaterThan(lhs, rhs) || isEqualTo(lhs, rhs) {
      return true
    }
    return false
  }
  
  static func isLessThanOrEqualTo(lhs: NSDecimalNumber, _ rhs: NSDecimalNumber) -> Bool {
    if isLessThan(lhs, rhs) || isEqualTo(lhs, rhs) {
      return true
    }
    return false
  }
  
  
}
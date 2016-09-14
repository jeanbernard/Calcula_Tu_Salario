//
//  Util.swift
//  Calcula Tu Salario
//
//  Created by Jean Bernard on 7/1/16.
//  Copyright © 2016 Jean Bernard. All rights reserved.
//

import Foundation

//MARK: Overloaded Arithmetic Operators

func + (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
  return lhs.adding(rhs)
}

func - (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
  return lhs.subtracting(rhs)
}

func * (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
  return lhs.multiplying(by: rhs)
}

func / (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
  return lhs.dividing(by: rhs)
}


//MARK: Overloaded Comparison Operators

func > (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
  return lhs.compare(rhs) == ComparisonResult.orderedDescending
}

func < (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
  return lhs.compare(rhs) == ComparisonResult.orderedAscending
}

func == (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
  return lhs.compare(rhs) == ComparisonResult.orderedSame
}

func >= (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
  if lhs > rhs || lhs == rhs {
    return true
  }
  return false
}

func <= (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
  if lhs < rhs || lhs == rhs {
    return true
  }
  return false
}


extension NSDecimalNumber {

  static func roundToNearestTwo(_ numberToRound: NSDecimalNumber) -> NSDecimalNumber {
    let roundBehaviour = NSDecimalNumberHandler(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    return numberToRound.rounding(accordingToBehavior: roundBehaviour)
  }
  
}

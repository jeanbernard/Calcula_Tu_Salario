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
  return lhs.decimalNumberByAdding(rhs)
}

func - (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
  return lhs.decimalNumberBySubtracting(rhs)
}

func * (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
  return lhs.decimalNumberByMultiplyingBy(rhs)
}

func / (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
  return lhs.decimalNumberByDividingBy(rhs)
}


//MARK: Overloaded Comparison Operators

func > (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
  return lhs.compare(rhs) == NSComparisonResult.OrderedDescending
}

func < (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
  return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
}

func == (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
  return lhs.compare(rhs) == NSComparisonResult.OrderedSame
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

  static func roundToNearestTwo(numberToRound: NSDecimalNumber) -> NSDecimalNumber {
    let roundBehaviour = NSDecimalNumberHandler(roundingMode: .RoundPlain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    return numberToRound.decimalNumberByRoundingAccordingToBehavior(roundBehaviour)
  }
  
}
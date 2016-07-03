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
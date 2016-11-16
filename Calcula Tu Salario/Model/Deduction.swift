import Foundation

enum Frequency: NSDecimalNumber {
  case monthly = 1
  case biWeekly = 2
}

enum TaxType: String {
  case government
  case custom
}

struct Deduction {
  var name: String
  var amount: NSDecimalNumber
  var percentage: NSDecimalNumber?
  var frequency: Frequency
  var type: TaxType
  var appliesForISR: Bool
  
  init(name: String, amount: NSDecimalNumber, percentage: NSDecimalNumber? = nil, frequency: Frequency, type: TaxType, appliesForISR: Bool) {
    self.name = name
    self.amount = amount
    self.percentage = percentage
    self.frequency = frequency
    self.type = type
    self.appliesForISR = appliesForISR
  }
  
}



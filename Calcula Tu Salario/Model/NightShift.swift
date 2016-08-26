import Foundation

private enum RatePercentage {
  static let nightShiftRate: NSDecimalNumber = 0.15
}

protocol NightShift {
  func nightShiftRate(forSalary salary: NSDecimalNumber) -> NSDecimalNumber
  func nightShiftTotalPay(forSalary salary: NSDecimalNumber, andNightlyRate rate: NSDecimalNumber) -> NSDecimalNumber
}

extension NightShift {
  
  func nightShiftRate(forSalary salary: NSDecimalNumber) -> NSDecimalNumber {
    let hourlyRate = salary / PaymentFrequency.monthly.rawValue / 8
    let nightShiftRate = (hourlyRate * RatePercentage.nightShiftRate) + hourlyRate
    return NSDecimalNumber.roundToNearestTwo(nightShiftRate)
  }
  
  func nightShiftTotalPay(forSalary salary: NSDecimalNumber , andNightlyRate rate: NSDecimalNumber) -> NSDecimalNumber {
    let nightShiftTotal = (rate * 8.0) * PaymentFrequency.monthly.rawValue
    let totalPay = nightShiftTotal - salary
    return NSDecimalNumber.roundToNearestTwo(totalPay)
  }

}
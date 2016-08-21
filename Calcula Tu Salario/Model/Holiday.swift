import Foundation

private enum RatePercentage {
  static let holidayHour: NSDecimalNumber = 1
}

protocol Holiday {
  func holidayTotalPay(forHourlyRate hourlyRate: NSDecimalNumber, andHolidayHours holidayHours: NSDecimalNumber) -> NSDecimalNumber
}

extension Holiday {
  func holidayTotalPay(forHourlyRate hourlyRate: NSDecimalNumber, andHolidayHours holidayHours: NSDecimalNumber) -> NSDecimalNumber {
    
    let extraRatePerHour = (hourlyRate * RatePercentage.holidayHour) + hourlyRate
    let total = holidayHours * extraRatePerHour
    
    return NSDecimalNumber.roundToNearestTwo(total)
  }
}


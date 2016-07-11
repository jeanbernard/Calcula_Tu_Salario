import Foundation

enum HourlyWage: NSDecimalNumber {
  case monthly = 23.83
  case biWeekly = 11.91
  case weekly = 5.5
}

private struct WorkingHours {
  static let legalWorkingHours: NSDecimalNumber = 44
}


struct Overtime {
  
  static func hourlyWage(salary: NSDecimalNumber, normalWorkingHours: NSDecimalNumber, frequency: HourlyWage) -> NSDecimalNumber {
    let hourlyWageResult = (salary / frequency.rawValue) / normalWorkingHours
    return NSDecimalNumber.roundToNearestTwo(hourlyWageResult)
  }
  
  static func extraHoursWorked(hoursWorked: NSDecimalNumber) -> NSDecimalNumber {
    let extraHoursWorkedResult = hoursWorked - WorkingHours.legalWorkingHours
    return extraHoursWorkedResult
  }
  
  static func extraHourlyWage(salary: NSDecimalNumber, normalWorkingHours hours: NSDecimalNumber, frequency: HourlyWage) -> NSDecimalNumber {
    let amountPerHour = hourlyWage(salary, normalWorkingHours: hours, frequency: frequency)
    let lawPercentDiscount = amountPerHour * 0.35
    let extraHourlyWageResult = amountPerHour + lawPercentDiscount
    return NSDecimalNumber.roundToNearestTwo(extraHourlyWageResult)
  }
  
  static func totalPay(extraHoursWorked hoursWorked: NSDecimalNumber, extraHourAmount: NSDecimalNumber) -> NSDecimalNumber {
    let totalPayResult = hoursWorked * extraHourAmount
    return NSDecimalNumber.roundToNearestTwo(totalPayResult)
  }
  
}
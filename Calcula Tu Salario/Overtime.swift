import Foundation

enum HourlyWage: NSDecimalNumber {
  case monthly = 23.83
  case biWeekly = 11.91
  case weekly = 5.5
}

private enum CompensationPercentage: NSDecimalNumber {
  case lessThan68Hours = 0.35
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
    let lawPercentDiscount = amountPerHour * CompensationPercentage.lessThan68Hours.rawValue
    let extraHourlyWageResult = amountPerHour + lawPercentDiscount
    return NSDecimalNumber.roundToNearestTwo(extraHourlyWageResult)
  }
  
  static func totalPay(salary: NSDecimalNumber, normalWorkingHours workingHours: NSDecimalNumber, totalHoursWorked hours: NSDecimalNumber, frequency: HourlyWage) -> NSDecimalNumber {
    let extraHours = extraHoursWorked(hours)
    let extraHourAmount = extraHourlyWage(salary, normalWorkingHours: workingHours, frequency: frequency)
    let totalPayResult = extraHours * extraHourAmount
    return NSDecimalNumber.roundToNearestTwo(totalPayResult)
  }
  
}
import Foundation

enum PaymentFrequency: NSDecimalNumber {
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
  
  static func hourlyWage(salary: NSDecimalNumber, normalWorkingHours: NSDecimalNumber, payFrequency: PaymentFrequency) -> NSDecimalNumber {
    let hourlyWageResult = (salary / payFrequency.rawValue) / normalWorkingHours
    return NSDecimalNumber.roundToNearestTwo(hourlyWageResult)
  }
  
  static func extraHoursWorked(hours: NSDecimalNumber) -> (hundredPercent: NSDecimalNumber, thiryFivePercent: NSDecimalNumber) {
    //let extraHoursWorkedResult = hoursWorked - WorkingHours.legalWorkingHours
    
    switch hours {
    case hours where hours > 68:
      return (hours - 68, 68 - 44)
    case hours where hours < 68:
      return (0, hours - 44)
    default:
      return (0,0)
    }
  }
  
  static func extraHourlyWage(salary: NSDecimalNumber, normalWorkingHours hours: NSDecimalNumber, frequency: PaymentFrequency) -> NSDecimalNumber {
    let amountPerHour = hourlyWage(salary, normalWorkingHours: hours, payFrequency: frequency)
    let lawPercentDiscount = amountPerHour * CompensationPercentage.lessThan68Hours.rawValue
    let extraHourlyWageResult = amountPerHour + lawPercentDiscount
    return NSDecimalNumber.roundToNearestTwo(extraHourlyWageResult)
  }
  
  //  static func totalPay(salary: NSDecimalNumber, normalWorkingHours workingHours: NSDecimalNumber, totalHoursWorked hours: NSDecimalNumber, payFrequency: PaymentFrequency) -> NSDecimalNumber {
  //    let extraHours = extraHoursWorked(hours)
  //    let extraHourAmount = extraHourlyWage(salary, normalWorkingHours: workingHours, frequency: payFrequency)
  //    let totalPayResult = extraHours * extraHourAmount
  //    return NSDecimalNumber.roundToNearestTwo(totalPayResult)
  //  }
  
}
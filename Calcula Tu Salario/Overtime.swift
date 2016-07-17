import Foundation

enum PaymentFrequency: NSDecimalNumber {
  case monthly = 23.83
  case biWeekly = 11.91
  case weekly = 5.5
}

private enum RatePercentage {
  static let lessThan68Hours: NSDecimalNumber = 0.35
  static let greaterThan68Hours: NSDecimalNumber = 1
}

private enum WorkingHours {
  static let legalWorkingHours: NSDecimalNumber = 44
  static let maximumAmountOfHours: NSDecimalNumber = 68
}


struct Overtime {
  
  static func ratePerHour(salary salary: NSDecimalNumber, workingHours: NSDecimalNumber, payFrequency: PaymentFrequency) -> NSDecimalNumber {
    let hourlyRateResult = (salary / payFrequency.rawValue) / workingHours
    return NSDecimalNumber.roundToNearestTwo(hourlyRateResult)
  }
  
  static func extraHoursWorked(total hours: NSDecimalNumber) -> (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) {
    
    let legalWorkingHours = WorkingHours.legalWorkingHours
    let maximumAmountOfHours = WorkingHours.maximumAmountOfHours
    
    switch hours {
    case hours where hours > maximumAmountOfHours:
      return (maximumAmountOfHours - legalWorkingHours, hours - maximumAmountOfHours)
    case hours where hours < maximumAmountOfHours:
      return (hours - legalWorkingHours, 0)
    default:
      return (0,0)
    }
  }
  
  static func extraRatePerHour(rate hourlyRate: NSDecimalNumber, hoursWorked hours: NSDecimalNumber) -> (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) {
    
    var rateOver68Hours: NSDecimalNumber = 0
    let rateUnder68Hours = NSDecimalNumber.roundToNearestTwo((hourlyRate * RatePercentage.lessThan68Hours) + hourlyRate)
    
    if hours > WorkingHours.maximumAmountOfHours {
      rateOver68Hours = (hourlyRate * RatePercentage.greaterThan68Hours) + hourlyRate
    }
    return (rateUnder68Hours, rateOver68Hours)
  }
  
  static func payPerPercentage(hoursWorked hours: NSDecimalNumber, hourlyRateUnder68Hours: NSDecimalNumber, hourlyRateOver68Hours: NSDecimalNumber) -> (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) {
    
    let extraHoursWorkedResult = extraHoursWorked(total: hours)
    
    let totalUnder68Hours = extraHoursWorkedResult.under68Hours * hourlyRateUnder68Hours
    var totalOver68Hours: NSDecimalNumber = 0
    
    if hours > WorkingHours.maximumAmountOfHours {
      totalOver68Hours = extraHoursWorkedResult.over68Hours * hourlyRateOver68Hours
    }
    return (totalUnder68Hours, totalOver68Hours)
  }
  
}
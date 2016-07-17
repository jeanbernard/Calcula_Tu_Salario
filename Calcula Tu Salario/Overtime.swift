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
  
  static func amountOfExtraHoursWorked(hours: NSDecimalNumber) -> (thiryFivePercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) {
    
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
  
  static func extraRatePerHour(rate hourlyRate: NSDecimalNumber, hoursWorked hours: NSDecimalNumber) -> (thirtyPercent: NSDecimalNumber, hundredPercent: NSDecimalNumber) {
    
    var rateAtHundredPercent: NSDecimalNumber = 0
    
    let rateAtThirtyFivePercent = NSDecimalNumber.roundToNearestTwo((hourlyRate * RatePercentage.lessThan68Hours) + hourlyRate)
    
    if hours > WorkingHours.maximumAmountOfHours {
      rateAtHundredPercent = (hourlyRate * RatePercentage.greaterThan68Hours) + hourlyRate
    }
    return (rateAtThirtyFivePercent, rateAtHundredPercent)
  }
  
  static func payPerPercentage(hoursWorked hours: NSDecimalNumber, hourlyRateThirtyFivePercent thirty: NSDecimalNumber, hourlyRateHundredPercent hundred: NSDecimalNumber) -> (totalAtThirtyPercent: NSDecimalNumber, totalAtHundredPercent: NSDecimalNumber) {
    
    let extraHoursWorked = amountOfExtraHoursWorked(hours)
    
    let totalAtThirtyFivePercent = extraHoursWorked.thiryFivePercent * thirty
    var totalAtHundredPercent: NSDecimalNumber = 0
    
    if hours > WorkingHours.maximumAmountOfHours {
      totalAtHundredPercent = extraHoursWorked.hundredPercent * hundred
    }
    return (totalAtThirtyFivePercent, totalAtHundredPercent)
  }
  
}
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
  
  static func ratePerHour(salary: NSDecimalNumber, normalWorkingHours: NSDecimalNumber, payFrequency: PaymentFrequency) -> NSDecimalNumber {
    let hourlyWageResult = (salary / payFrequency.rawValue) / normalWorkingHours
    return NSDecimalNumber.roundToNearestTwo(hourlyWageResult)
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
  
  static func payPerPercentage(thirtyFivePercent thirty: NSDecimalNumber, hundredPercent hundred: NSDecimalNumber) -> (totalAtThirtyPercent: NSDecimalNumber, totalAtHundredPercent: NSDecimalNumber) {
    
    
    
    return (2_310.00, 1_701.60)
    
  }
  
  
  
  //  static func totalPay(salary: NSDecimalNumber, normalWorkingHours workingHours: NSDecimalNumber, totalHoursWorked hours: NSDecimalNumber, payFrequency: PaymentFrequency) -> NSDecimalNumber {
  //    let extraHours = extraHoursWorked(hours)
  //    let extraHourAmount = extraHourlyWage(salary, normalWorkingHours: workingHours, frequency: payFrequency)
  //    let totalPayResult = extraHours * extraHourAmount
  //    return NSDecimalNumber.roundToNearestTwo(totalPayResult)
  //  }
  
}
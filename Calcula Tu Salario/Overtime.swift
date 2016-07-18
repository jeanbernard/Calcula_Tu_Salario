import Foundation

enum PaymentFrequency: NSDecimalNumber {
  case monthly = 23.83
  case biWeekly = 11.91
  case weekly = 5.5
}

private enum RatePercentage {
  static let lessThan68Hours: NSDecimalNumber = 0.35
  static let greaterThan68Hours: NSDecimalNumber = 1
  static let nightShift: NSDecimalNumber = 0.15
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
  
  static func extraHoursWorked(hours hours: NSDecimalNumber) -> (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) {
    
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
  
  static func extraRatePerHour(hourlyRate hourlyRate: NSDecimalNumber, hoursWorked hours: NSDecimalNumber) -> (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) {
    
    var rateOver68Hours: NSDecimalNumber = 0
    let rateUnder68Hours = NSDecimalNumber.roundToNearestTwo((hourlyRate * RatePercentage.lessThan68Hours) + hourlyRate)
    
    if hours > WorkingHours.maximumAmountOfHours {
      rateOver68Hours = (hourlyRate * RatePercentage.greaterThan68Hours) + hourlyRate
    }
    return (rateUnder68Hours, rateOver68Hours)
  }
  
  static func totalPay(hourlyRate hourlyRate: NSDecimalNumber, hoursWorked hours: NSDecimalNumber) -> (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) {
    
    let extraHoursWorkedResult = extraHoursWorked(hours: hours)
    let extraRatePerHourResult = extraRatePerHour(hourlyRate: hourlyRate, hoursWorked: hours)
    
    let totalUnder68Hours = extraHoursWorkedResult.under68Hours * extraRatePerHourResult.under68Hours
    var totalOver68Hours: NSDecimalNumber = 0
    
    if hours > WorkingHours.maximumAmountOfHours {
      totalOver68Hours = extraHoursWorkedResult.over68Hours * extraRatePerHourResult.over68Hours
    }
    return (totalUnder68Hours, totalOver68Hours)
  }
  
  static func nightShiftRate(salary salary: NSDecimalNumber, workingNightHours nightHours: NSDecimalNumber, payFrequency frequency: PaymentFrequency) -> NSDecimalNumber {
    
    let normalRatePerHour = ratePerHour(salary: salary, workingHours: nightHours, payFrequency: frequency)
    let nightlyRate = NSDecimalNumber.roundToNearestTwo((normalRatePerHour * RatePercentage.nightShift) + normalRatePerHour)
    
    return nightlyRate
  }
  
  static func nightShiftTotalPay(salary salary: NSDecimalNumber, workingNightHours: NSDecimalNumber, payFrequency: PaymentFrequency) -> NSDecimalNumber {
    
    let hourlyNightShiftRate = nightShiftRate(salary: salary, workingNightHours: workingNightHours, payFrequency: payFrequency)
    let nightShiftAmountTotal = NSDecimalNumber.roundToNearestTwo((hourlyNightShiftRate * workingNightHours) * payFrequency.rawValue)
    let totalPay = nightShiftAmountTotal - salary
    
    return totalPay
  }
  
}
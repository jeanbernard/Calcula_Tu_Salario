import Foundation

enum PaymentFrequency: NSDecimalNumber {
  case monthly = 23.83
  case biWeekly = 11.91
  case weekly = 5.5
}

private enum CompensationPercentage {
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
  
  static func amountOfExtraHoursWorked(hours: NSDecimalNumber) -> (hundredPercent: NSDecimalNumber, thiryFivePercent: NSDecimalNumber) {
    
    let legalWorkingHours = WorkingHours.legalWorkingHours
    let maximumAmountOfHours = WorkingHours.maximumAmountOfHours
    
    switch hours {
    case hours where hours > maximumAmountOfHours:
      return (hours - maximumAmountOfHours, maximumAmountOfHours - legalWorkingHours)
    case hours where hours < maximumAmountOfHours:
      return (0, hours - legalWorkingHours)
    default:
      return (0,0)
    }
  }
  
  static func extraRatePerHour(rate hourlyRate: NSDecimalNumber, hoursWorked hours: NSDecimalNumber) -> (thirtyPercent: NSDecimalNumber, hundredPercent: NSDecimalNumber?) {
    
    var rateAtHundredPercent: NSDecimalNumber?
    
    let rateAtThirtyFivePercent = NSDecimalNumber.roundToNearestTwo((hourlyRate * CompensationPercentage.lessThan68Hours) + hourlyRate)
    
    if hours > 68 {
      rateAtHundredPercent = (hourlyRate * CompensationPercentage.greaterThan68Hours) + hourlyRate
    }
    return (rateAtThirtyFivePercent, rateAtHundredPercent)
  }
  
  static func extraHourlyWage(salary: NSDecimalNumber, normalWorkingHours hours: NSDecimalNumber, hoursWorked: NSDecimalNumber, frequency: PaymentFrequency) -> NSDecimalNumber {
    let amountPerHour = ratePerHour(salary, normalWorkingHours: hours, payFrequency: frequency)
    let extraHoursWorked = Overtime.amountOfExtraHoursWorked(hoursWorked)
    
    let lawPercentDiscountUnder35 = NSDecimalNumber.roundToNearestTwo((amountPerHour * CompensationPercentage.lessThan68Hours) + amountPerHour)
    let lawPercentDiscountOver35 = (amountPerHour * CompensationPercentage.greaterThan68Hours) + amountPerHour
    
    let valueExtraHourBelow68 = lawPercentDiscountUnder35 * extraHoursWorked.thiryFivePercent
    
    let valueExtraHourAbove68 = lawPercentDiscountOver35 * extraHoursWorked.hundredPercent
    
    let extraHourlyWageResult = valueExtraHourAbove68 + valueExtraHourBelow68
    return NSDecimalNumber.roundToNearestTwo(extraHourlyWageResult)
  }
  
  
  
  //  static func totalPay(salary: NSDecimalNumber, normalWorkingHours workingHours: NSDecimalNumber, totalHoursWorked hours: NSDecimalNumber, payFrequency: PaymentFrequency) -> NSDecimalNumber {
  //    let extraHours = extraHoursWorked(hours)
  //    let extraHourAmount = extraHourlyWage(salary, normalWorkingHours: workingHours, frequency: payFrequency)
  //    let totalPayResult = extraHours * extraHourAmount
  //    return NSDecimalNumber.roundToNearestTwo(totalPayResult)
  //  }
  
}
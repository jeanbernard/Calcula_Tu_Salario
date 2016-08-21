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

protocol Overtime {
  func doesSalaryApplyForOvertimePay(extraHours hours: NSDecimalNumber) -> Bool
  
  func ratePerHour(salary salary: NSDecimalNumber,
                          workingHours: NSDecimalNumber,
                          payFrequency: PaymentFrequency) -> NSDecimalNumber
  
  func extraHoursWorked(hours hours: NSDecimalNumber) -> (
    under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber)
  
  func extraRatePerHour(rate hourlyRate: NSDecimalNumber,
                        extraHours hours: NSDecimalNumber) ->
                        (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber)
  
  func totalExtraHoursWorked(forHours hours: NSDecimalNumber) -> NSDecimalNumber
  
  func totalPay(forHourlyRate hourlyRate: NSDecimalNumber,
                andExtraHoursWorked hours: NSDecimalNumber) ->
                (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber)
  
  func nightShiftRate(salary salary: NSDecimalNumber,
                      workingNightHours nightHours: NSDecimalNumber,
                      payFrequency frequency: PaymentFrequency) -> NSDecimalNumber
}


extension Overtime {
  
  func doesSalaryApplyForOvertimePay(extraHours hours: NSDecimalNumber) -> Bool {
    
    if hours > 0 {
      return true
    }
    return false
  }
  
  func ratePerHour(salary salary: NSDecimalNumber, workingHours: NSDecimalNumber,
                                 payFrequency: PaymentFrequency) -> NSDecimalNumber {
    
    let hourlyRateResult = (salary / payFrequency.rawValue) / workingHours
    return NSDecimalNumber.roundToNearestTwo(hourlyRateResult)
  }
  
  func extraHoursWorked(hours hours: NSDecimalNumber) -> (under68Hours: NSDecimalNumber,
    over68Hours: NSDecimalNumber) {
    
    let legalWorkingHours = WorkingHours.legalWorkingHours
    let maximumAmountOfHours = WorkingHours.maximumAmountOfHours
    let totalExtraHours = totalExtraHoursWorked(forHours: hours)
    
    switch totalExtraHours {
    case totalExtraHours where totalExtraHours > maximumAmountOfHours:
      return (maximumAmountOfHours - legalWorkingHours, totalExtraHours - maximumAmountOfHours)
    case totalExtraHours where totalExtraHours <= maximumAmountOfHours:
      return (totalExtraHours - legalWorkingHours, 0)
    default:
      return (0,0)
    }
  }
  
  func extraRatePerHour(rate hourlyRate: NSDecimalNumber,
                             extraHours hours: NSDecimalNumber) ->
                            (under68Hours: NSDecimalNumber, over68Hours: NSDecimalNumber) {
      
      var rateOver68Hours: NSDecimalNumber = 0
      let rateUnder68Hours = (hourlyRate * RatePercentage.lessThan68Hours) + hourlyRate
      let totalExtraHours = totalExtraHoursWorked(forHours: hours)
      
      if totalExtraHours > WorkingHours.maximumAmountOfHours {
        rateOver68Hours = (hourlyRate * RatePercentage.greaterThan68Hours) + hourlyRate
      }
      return (NSDecimalNumber.roundToNearestTwo(rateUnder68Hours),
              NSDecimalNumber.roundToNearestTwo(rateOver68Hours))
  }
  
  func totalExtraHoursWorked(forHours hours: NSDecimalNumber) -> NSDecimalNumber {
    return hours + WorkingHours.legalWorkingHours
  }
  
  
  func totalPay(forHourlyRate hourlyRate: NSDecimalNumber, andExtraHoursWorked hours: NSDecimalNumber) ->
    (totalUnder68Hours: NSDecimalNumber, totalOver68Hours: NSDecimalNumber) {
      
      let extraHoursWorkedResult = extraHoursWorked(hours: hours)
      let extraRatePerHourResult = extraRatePerHour(rate: hourlyRate, extraHours: hours)
      let totalExtraHours = totalExtraHoursWorked(forHours: hours)
      
      let totalUnder68Hours = extraHoursWorkedResult.under68Hours * extraRatePerHourResult.under68Hours
      var totalOver68Hours: NSDecimalNumber = 0
      
      if totalExtraHours > WorkingHours.maximumAmountOfHours {
        totalOver68Hours = extraHoursWorkedResult.over68Hours * extraRatePerHourResult.over68Hours
      }
      return (NSDecimalNumber.roundToNearestTwo(totalUnder68Hours),
              NSDecimalNumber.roundToNearestTwo(totalOver68Hours))
  }
  
  func nightShiftRate(salary salary: NSDecimalNumber, workingNightHours nightHours: NSDecimalNumber,
                                    payFrequency frequency: PaymentFrequency) -> NSDecimalNumber {
    
    let normalRatePerHour = ratePerHour(salary: salary,
                                        workingHours: nightHours,
                                        payFrequency: frequency)
    let nightlyRate = (normalRatePerHour * RatePercentage.nightShift) + normalRatePerHour
    
    return NSDecimalNumber.roundToNearestTwo(nightlyRate)
  }
  //
  //  static func nightShiftTotalPay(salary salary: NSDecimalNumber, workingNightHours: NSDecimalNumber,
  //                                        payFrequency: PaymentFrequency) -> NSDecimalNumber {
  //
  //    let hourlyNightShiftRate = nightShiftRate(salary: salary,
  //                                              workingNightHours: workingNightHours,
  //                                              payFrequency: payFrequency)
  //    let nightShiftAmountTotal = (hourlyNightShiftRate * workingNightHours) * payFrequency.rawValue
  //    let totalPay = nightShiftAmountTotal - salary
  //
  //    return NSDecimalNumber.roundToNearestTwo(totalPay)
  //  }
  
}

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
  
  static func extraAmountPerHour(hourlyWage: NSDecimalNumber) -> NSDecimalNumber {
  
  let lawPercentDiscount = hourlyWage * 0.35
  let extraHourAmountResult = hourlyWage + lawPercentDiscount
  
  return NSDecimalNumber.roundToNearestTwo(extraHourAmountResult)
  
  }
  
}
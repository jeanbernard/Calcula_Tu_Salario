import Foundation

enum HourlyWage: NSDecimalNumber {
  case monthly = 23.83
  case biWeekly = 11.91
  case weekly = 5.5
}


struct Overtime {
  
  static func hourlyWage(salary: NSDecimalNumber, hoursWorked: NSDecimalNumber, frequency: HourlyWage) -> NSDecimalNumber {
    
    let hourlyWageResult = (salary / frequency.rawValue) / hoursWorked
    
    return NSDecimalNumber.roundToNearestTwo(hourlyWageResult)
  }
  
}
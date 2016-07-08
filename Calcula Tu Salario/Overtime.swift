import Foundation

enum HourlyWage: NSDecimalNumber {
  case Monthly = 23.83
  case BiWeekly = 11.91
  case Weekly = 5.5
}


struct Overtime {
  
  static func hourlyWage(salary: NSDecimalNumber, hoursWorked: NSDecimalNumber, frequency: HourlyWage) -> NSDecimalNumber {
    
    let hourlyWageResult = (salary / frequency.rawValue) / hoursWorked
    
    return NSDecimalNumber.roundToNearestTwo(hourlyWageResult)
  }
  
}
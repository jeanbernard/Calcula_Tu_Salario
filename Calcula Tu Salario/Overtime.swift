import Foundation

private enum HourlyPay: NSDecimalNumber {
  case Monthly = 23.83
  case BiWeekly = 11.91
}


struct Overtime {
  
  static func calculateHourlyOvertimePayPerMonth(salary: NSDecimalNumber, hoursWorked: NSDecimalNumber) -> NSDecimalNumber {
    
    let hourlyOvertimePayPerMonth = (salary / HourlyPay.Monthly.rawValue) / hoursWorked
    
    return NSDecimalNumber.roundToNearestTwo(hourlyOvertimePayPerMonth)
  }
  
  static func calculateHourlyOvertimePayPerBiWeekly(salary: NSDecimalNumber, hoursWorked: NSDecimalNumber) -> NSDecimalNumber {
    
    let hourlyOvertimePayPerBiWeekly = (salary / HourlyPay.BiWeekly.rawValue) / hoursWorked
  
    return NSDecimalNumber.roundToNearestTwo(hourlyOvertimePayPerBiWeekly)
  }
  
}
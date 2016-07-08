import Foundation

private enum HourlyPay: NSDecimalNumber {
  case Monthly = 23.83
}


struct Overtime {
  
  static func calculateHourlyOvertimePayPerMonth(salary: NSDecimalNumber, hoursWorked: NSDecimalNumber) -> NSDecimalNumber {
    
    let hourlyOvertimePayPerMonth = (salary / HourlyPay.Monthly.rawValue) / hoursWorked
    
    return NSDecimalNumber.roundToNearestTwo(hourlyOvertimePayPerMonth)
  }
  
}
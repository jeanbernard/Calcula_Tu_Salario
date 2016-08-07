import Foundation

protocol Tax {
  func isSalaryExemptFromISR(salary: NSDecimalNumber) -> Bool
  func getPercentage(salary: NSDecimalNumber) -> NSDecimalNumber
  func getSurplus(salary: NSDecimalNumber) -> NSDecimalNumber
  func getRateNumber(percent: NSDecimalNumber) -> NSDecimalNumber
  func getYearlyRetentionAmount(salary: NSDecimalNumber) -> NSDecimalNumber
  func obtainDeductions(forSalary salary: NSDecimalNumber) -> [String: NSDecimalNumber]
}


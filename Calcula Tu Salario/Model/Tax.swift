import Foundation

protocol Taxable {
  func isSalaryExemptFromISR(_ salary: NSDecimalNumber) -> Bool
  func getPercentage(_ salary: NSDecimalNumber) -> NSDecimalNumber
  func getSurplus(_ salary: NSDecimalNumber) -> NSDecimalNumber
  func getRateNumber(_ percent: NSDecimalNumber) -> NSDecimalNumber
  func getYearlyRetentionAmount(_ salary: NSDecimalNumber) -> NSDecimalNumber
  func calculateGovernmentTaxes(forSalary salary: NSDecimalNumber) -> [Deduction]
}


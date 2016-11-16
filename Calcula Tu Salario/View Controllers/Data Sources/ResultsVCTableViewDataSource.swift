import UIKit

extension ResultsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return payroll.incomes.count
    } else {
      return payroll.deductions.count
    }
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultTableViewCell
    
    if (indexPath as NSIndexPath).section == 0 {
      let greenColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
      cell.titleLabel.text = payroll.incomes[(indexPath as NSIndexPath).row].name
      cell.amountLabel.text = formatNumberToCurrencyString(payroll.incomes[(indexPath as NSIndexPath).row].amount)
      cell.amountLabel.textColor = greenColor
      cell.percentageLabel.text = ""
    } else {
      cell.titleLabel.text = payroll.deductions[(indexPath as NSIndexPath).row].name
      cell.amountLabel.text = formatNumberToCurrencyString(payroll.deductions[(indexPath as NSIndexPath).row].amount)
      
      //TODO: Create function to show the percentages correctly. Perhaps create a struct with Type methods to handle conversion between NSDecimalNumber to String and vice versa.
      if let percentage = payroll.deductions[(indexPath as NSIndexPath).row].percentage {
        cell.percentageLabel.text = formatNumberToCurrencyString(percentage * 100)?.replacingOccurrences(of: "$", with: "")
        cell.percentageLabel.text?.append("%")
      } else {
        cell.percentageLabel.text = ""
      }
      
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "Ingresos"
    } else {
      return "Deducciones"
    }
  }
  
}

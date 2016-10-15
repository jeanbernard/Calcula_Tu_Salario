import UIKit

extension ResultsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return salaryViewModel.viewIncome.count
    } else {
      return salaryViewModel.viewDeductions.count
    }
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let deductionNames = [String](salaryViewModel.viewDeductions.keys)
    let incomeNames = [String](salaryViewModel.viewIncome.keys)
    let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultTableViewCell
    
    if (indexPath as NSIndexPath).section == 0 {
      cell.titleLabel.text = incomeNames[(indexPath as NSIndexPath).row]
      cell.amountLabel.text = salaryViewModel.viewIncome[incomeNames[(indexPath as NSIndexPath).row]]!
      let greenColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
      cell.amountLabel.textColor = greenColor
      cell.percentageLabel.text = ""
    } else {
      cell.titleLabel.text = deductionNames[(indexPath as NSIndexPath).row]
      cell.amountLabel.text = salaryViewModel.viewDeductions[deductionNames[(indexPath as NSIndexPath).row]]!
      
      let deductionPercentage = deductionNames[(indexPath as NSIndexPath).row]
      
      if deductionPercentage == "AFP" {
        cell.percentageLabel.text = "2.87%"
      }
      
      else if deductionPercentage == "SFS" {
        cell.percentageLabel.text = "3.04%"
      }
      
      else if deductionPercentage == "ISR" {
        cell.percentageLabel.text = salaryViewModel.viewISRPercentage
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

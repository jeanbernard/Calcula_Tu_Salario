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
    } else {
      cell.titleLabel.text = deductionNames[(indexPath as NSIndexPath).row]
      cell.amountLabel.text = salaryViewModel.viewDeductions[deductionNames[(indexPath as NSIndexPath).row]]!
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

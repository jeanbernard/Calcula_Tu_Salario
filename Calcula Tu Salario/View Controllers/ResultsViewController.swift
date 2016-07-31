import UIKit

class ResultsViewController: UIViewController {
  
  var salaryViewModel = SalaryViewModel()
  
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var resultsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resultsTableView.dataSource = self
    resultsTableView.tableFooterView = UIView()
    resultsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    resultLabel.text = salaryViewModel.netSalary
  }
}

//MARK: Data Source

extension ResultsViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return 1
    } else {
      return salaryViewModel.deductions.count
    }
    
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let deductionNames = [String](salaryViewModel.deductions.keys)
    let cell = tableView.dequeueReusableCellWithIdentifier("resultCell") as! ResultTableViewCell
    
    if indexPath.section == 0 {
      cell.titleLabel.text = "Salario"
      cell.amountLabel.text = salaryViewModel.income
    } else {
      cell.titleLabel.text = "\(deductionNames[indexPath.row])"
      cell.amountLabel.text = "\(salaryViewModel.deductions[deductionNames[indexPath.row]]!)"
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "Ingresos"
    } else {
      return "Deducciones"
    }
  }
  
}

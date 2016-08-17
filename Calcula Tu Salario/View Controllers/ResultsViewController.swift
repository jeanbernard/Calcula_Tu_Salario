import UIKit

class ResultsViewController: UIViewController {
  
  var salaryViewModel = SalaryViewModel()
  
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var resultsTableView: UITableView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resultsTableView.dataSource = self
    prepareTableView(resultsTableView)
    resultLabel.text = salaryViewModel.viewNetSalary
  }

  @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
    
    let monthly = 0
    let biWeekly = 1
    
    switch segmentedControl.selectedSegmentIndex {
    case monthly:
      salaryViewModel.showMonthlyResults()
      resultLabel.text = salaryViewModel.viewNetSalary
      resultsTableView.reloadData()
    case biWeekly:
      salaryViewModel.showBiWeeklyResults()
      resultLabel.text = salaryViewModel.viewNetSalary
      resultsTableView.reloadData()
    default:
      break
    }
  }
  
}


private func prepareTableView(tableView: UITableView) -> UITableView {
  tableView.tableFooterView = UIView()
  tableView.separatorStyle = UITableViewCellSeparatorStyle.None
  return tableView
}

//MARK: Data Source

extension ResultsViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return salaryViewModel.viewIncome.count
    } else {
      return salaryViewModel.viewDeductions.count
    }
    
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let deductionNames = [String](salaryViewModel.viewDeductions.keys)
    let incomeNames = [String](salaryViewModel.viewIncome.keys)
    let cell = tableView.dequeueReusableCellWithIdentifier("resultCell") as! ResultTableViewCell
    
    if indexPath.section == 0 {
      cell.titleLabel.text = incomeNames[indexPath.row]
      cell.amountLabel.text = salaryViewModel.viewIncome[incomeNames[indexPath.row]]!
    } else {
      cell.titleLabel.text = deductionNames[indexPath.row]
      cell.amountLabel.text = salaryViewModel.viewDeductions[deductionNames[indexPath.row]]!
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

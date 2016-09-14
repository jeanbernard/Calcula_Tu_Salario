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

  @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    
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


private func prepareTableView(_ tableView: UITableView) {
  tableView.tableFooterView = UIView()
  tableView.separatorStyle = UITableViewCellSeparatorStyle.none
}

//MARK: Data Source

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

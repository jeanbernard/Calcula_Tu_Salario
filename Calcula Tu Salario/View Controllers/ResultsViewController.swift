import UIKit

class ResultsViewController: UIViewController {
  
  var salaryViewModel = SalaryViewModel()
  
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var resultsTableView: UITableView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resultsTableView.dataSource = self
    resultsTableView.delegate = self
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("performed segue")
  }
  
}

private func prepareTableView(_ tableView: UITableView) {
  tableView.tableFooterView = UIView()
  tableView.separatorStyle = UITableViewCellSeparatorStyle.none
  //tableView.backgroundColor = UIColor.clear
}

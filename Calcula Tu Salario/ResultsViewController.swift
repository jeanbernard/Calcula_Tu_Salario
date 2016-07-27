import UIKit

class ResultsViewController: UIViewController {
  
  var salaryViewModel = SalaryViewModel()
  
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var resultsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resultsTableView.dataSource = self
    resultLabel.text = "$\(salaryViewModel.netSalary)"
  }
}

extension ResultsViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return salaryViewModel.deductions.count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("resultCell") as? ResultTableViewCell
    
    if indexPath.section == 0 {
      cell?.titleLabel.text = "Salario"
      cell?.amountLabel.text = "$10,000.00"
    } else {
      cell?.titleLabel.text = "Hello"
      cell?.amountLabel.text = "\(salaryViewModel.deductions[indexPath.row])"
    }
    
    return cell!
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "Ingresos"
    } else {
      return "Deducciones"
    }
  }
  
}

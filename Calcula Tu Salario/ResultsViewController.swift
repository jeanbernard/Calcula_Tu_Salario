import UIKit

class ResultsViewController: UIViewController {
  
  var result: NSDecimalNumber = 0.0
  
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var resultsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resultsTableView.dataSource = self
    resultLabel.text = "$\(result)"
  }
}

extension ResultsViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCellWithIdentifier("resultCell") as? ResultTableViewCell
    
    if indexPath.section == 0 {
      cell?.titleLabel.text = "Salario"
      cell?.amountLabel.text = "$10,000.00"
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

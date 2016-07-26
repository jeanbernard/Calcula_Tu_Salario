import UIKit

class SalaryViewController: UIViewController {
  
  var calculatedSalary: NSDecimalNumber = 0.0
  
  @IBOutlet weak var salaryTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destinationVC = segue.destinationViewController as? ResultsViewController {
      destinationVC.result = calculatedSalary
    }
  }
  
  @IBAction func payMeButtonPressed(sender: UIButton) {
    if let introducedSalary = salaryTextField.text where salaryTextField.text != "" {
      let salary = NSDecimalNumber(string: introducedSalary)
      calculatedSalary = Payroll.calculateMonthlyNetSalary(salary)
    } else {
      //TODO: Add UIAlertController "Must enter salary."
    }
  }
  
}

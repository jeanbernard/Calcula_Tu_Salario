import UIKit

class SalaryViewController: UIViewController {
  
  @IBOutlet weak var salaryTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destinationVC = segue.destinationViewController as? ResultsViewController {
      if let introducedSalary = salaryTextField.text where salaryTextField.text != "" {
        let salary = NSDecimalNumber(string: introducedSalary)
        let salaryViewModel = SalaryViewModel(salary: salary)
        destinationVC.salaryViewModel = salaryViewModel
      } else {
        //TODO: Add UIAlertController "Must enter salary."
      }
    }
  }
  
}

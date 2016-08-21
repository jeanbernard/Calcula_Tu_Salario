import UIKit

private enum Segue: String {
  case showResults
}

class SalaryViewController: UIViewController {
  
  @IBOutlet weak var salaryTextField: UITextField!
  
  private var extraHours: NSDecimalNumber = 0.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareGestureRecognizer()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if let identifier = segue.identifier {
      switch identifier {
        
      case Segue.showResults.rawValue:
        if let destinationVC = segue.destinationViewController as? ResultsViewController {
          if let introducedSalary = salaryTextField.text where salaryTextField.text != "" {
            let salary = NSDecimalNumber(string: introducedSalary)
            var salaryViewModel = SalaryViewModel()
            salaryViewModel = SalaryViewModel(salary: salary)
            destinationVC.salaryViewModel = salaryViewModel
          } else {
            //TO-DO: Add UIAlertController "Must enter salary."
          }
        }
      default: break
      }
    }
  }
  
  private func prepareGestureRecognizer() {
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SalaryViewController.allTextFieldsResignFirstResponder)))
  }
  
  @objc private func allTextFieldsResignFirstResponder() {
    salaryTextField.resignFirstResponder()
  }
  
}



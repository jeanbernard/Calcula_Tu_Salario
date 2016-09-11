import UIKit

private enum Segue: String {
  case showResults
  case showSettings
}

class SalaryViewController: UIViewController {
  
  var isNightShiftOn: Bool = false
  @IBOutlet weak var salaryTextField: UITextField!
  @IBOutlet weak var deductionsTableView: UITableView!
  @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var scrollView: UIScrollView!
  
  var rows = [String]()
  var rowCount = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareDeductionsTableView(deductionsTableView)
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if let identifier = segue.identifier {
      
      switch identifier {
        
      case Segue.showResults.rawValue:
        if let destinationVC = segue.destinationViewController as? ResultsViewController {
          if let introducedSalary = salaryTextField.text where salaryTextField.text != "" {
            
            let salary = NSDecimalNumber(string: introducedSalary)
            let customDeductions = prepareCustomDeductions()
            var salaryViewModel = SalaryViewModel()
            salaryViewModel = SalaryViewModel(salary: salary, shift: isNightShiftOn, customDeductions: customDeductions)
            destinationVC.salaryViewModel = salaryViewModel
            
          } else {
            //TO-DO: Add UIAlertController "Must enter salary."
          }
        }
        
      case Segue.showSettings.rawValue:
        if let navCon = segue.destinationViewController as? UINavigationController {
          if let settingsVC = navCon.visibleViewController as? SettingsTableViewController {
            settingsVC.delegate = self
          }
        }
        
      default: break
        
      }
      
    }
  }
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    var shouldPerformSegue = true
    
    for (index, _) in rows.enumerate() {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      let cell = deductionsTableView.cellForRowAtIndexPath(indexPath) as! DeductionTableViewCell
      
      if cell.deductionNameTextField.text == "" || cell.deductionAmountTextField.text == "" {
        shouldPerformSegue = false
        break
      }
    }
    
    if !shouldPerformSegue {
      let alert = UIAlertController(title: "Oh no!", message: "Te falta por completar deducciones :(", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.Default, handler: nil))
      presentViewController(alert, animated: true, completion: nil)
    }
    
    return shouldPerformSegue
  }
  
  func prepareCustomDeductions() -> [Deduction] {
    var deductions = [Deduction]()
    
    for (index, _) in rows.enumerate() {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      let cell = deductionsTableView.cellForRowAtIndexPath(indexPath) as! DeductionTableViewCell
      let deduction = Deduction(name: cell.deductionNameTextField.text!,
                                amount: NSDecimalNumber(string: cell.deductionAmountTextField.text!))
      deductions.append(deduction)
    }
    return deductions
  }
  
}

extension SalaryViewController: SettingsDelegate {
  func isNightShiftEnabled(switchButton: UISwitch) {
    isNightShiftOn = switchButton.on
  }
}





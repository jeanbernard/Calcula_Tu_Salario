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
    prepareTextFields(salaryTextField)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let identifier = segue.identifier {
      
      switch identifier {
        
      case Segue.showResults.rawValue:
        if let destinationVC = segue.destination as? ResultsViewController {
          if let introducedSalary = salaryTextField.text , salaryTextField.text != "" {
            
            let salary = NSDecimalNumber(string: introducedSalary)
            let customDeductions = prepareCustomDeductions()
            var salaryViewModel = SalaryViewModel()
            salaryViewModel = SalaryViewModel(salary: salary, shift: isNightShiftOn, customDeductions: customDeductions)
            destinationVC.salaryViewModel = salaryViewModel

          }
        }
        
      case Segue.showSettings.rawValue:
        if let navCon = segue.destination as? UINavigationController {
          if let settingsVC = navCon.visibleViewController as? SettingsTableViewController {
            settingsVC.delegate = self
          }
        }
        
      default: break
        
      }
      
    }
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    
    var shouldPerformSegue = true
    
    for (index, _) in rows.enumerated() {
      let indexPath = IndexPath(row: index, section: 0)
      let cell = deductionsTableView.cellForRow(at: indexPath) as! DeductionTableViewCell
      
      if cell.deductionNameTextField.text == "" || cell.deductionAmountTextField.text == "" {
        let alert = UIAlertController(title: "Oh no!", message: "Te falta por completar deducciones :(", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
        shouldPerformSegue = false
        break
      }
    }
    
    if let salaryText = salaryTextField.text {
      if salaryText == "" {
        let alert = UIAlertController(title: "Oh no!", message: "Introduzca salario! :(", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
        shouldPerformSegue = false
        return shouldPerformSegue
      }
    }
    
    return shouldPerformSegue

  }
  
  func prepareCustomDeductions() -> [Deduction] {
    var deductions = [Deduction]()
    
    for (index, _) in rows.enumerated() {
      let indexPath = IndexPath(row: index, section: 0)
      let cell = deductionsTableView.cellForRow(at: indexPath) as! DeductionTableViewCell
      let deduction = Deduction(name: cell.deductionNameTextField.text!,
                                amount: NSDecimalNumber(string: cell.deductionAmountTextField.text!))
      deductions.append(deduction)
    }
    return deductions
  }
  
}

extension SalaryViewController: SettingsDelegate {
  func isNightShiftEnabled(_ switchButton: UISwitch) {
    isNightShiftOn = switchButton.isOn
  }
}


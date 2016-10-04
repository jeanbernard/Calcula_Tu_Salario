import UIKit

private enum Segue: String {
  case showResults
  case showSettings
}

class SalaryViewController: UIViewController {
  
  var isNightShiftOn: Bool = false
  
  @IBOutlet weak var salaryTextField: UITextField!
  @IBOutlet weak var deductionsTableView: UITableView!
  @IBOutlet weak var incomeTableView: UITableView!
  @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var deductionsTableViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var incomeTableViewHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var contentView: UIView!
  
  var rows = [String]()
  var rowCount = 0
  
  var incomeRows = [String]()
  var incomeRowCount = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareTableView(for: deductionsTableView)
    prepareTableView(for: incomeTableView)
    prepareTextFields(salaryTextField)
    
    NotificationCenter.default.addObserver(self, selector: #selector(SalaryViewController.checkDynamicTypeChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(SalaryViewController.keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func keyboardWasShown(_ notification: NSNotification) {
    
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 60, right: 0)
      scrollView.contentInset = contentInsets
    }
    
  }
  
  func checkDynamicTypeChange () {
    salaryTextField.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let identifier = segue.identifier {
      
      switch identifier {
        
      case Segue.showResults.rawValue:
        if let destinationVC = segue.destination as? ResultsViewController {
          if let introducedSalary = salaryTextField.text , salaryTextField.text != "" {
            
            let salary = NSDecimalNumber(string: introducedSalary)
            let customDeductions = prepareCustomDeductions()
            let customIncomes = prepareCustomIncomes()
            var salaryViewModel = SalaryViewModel()
            
            salaryViewModel = SalaryViewModel(salary: salary,
                                              shift: isNightShiftOn,
                                              customDeductions: customDeductions,
                                              customIncomes: customIncomes)
            
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
  
  fileprivate func prepareCustomDeductions() -> [Deduction] {
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
  
  fileprivate func prepareCustomIncomes() -> [Income] {
    var incomes = [Income]()
    
    for (index, _) in incomeRows.enumerated() {
      let indexPath = IndexPath(row: index, section: 0)
      let cell = incomeTableView.cellForRow(at: indexPath) as! DeductionTableViewCell
      let income = Income(name: cell.deductionNameTextField.text!,
                          amount: NSDecimalNumber(string: cell.deductionAmountTextField.text!))
      incomes.append(income)
    }
    return incomes
  }
  
}

extension SalaryViewController: SettingsDelegate {
  func isNightShiftEnabled(_ switchButton: UISwitch) {
    isNightShiftOn = switchButton.isOn
  }
}


import UIKit

private enum Segue: String {
  case showResults
  case showSettings
}

class SalaryViewController: UIViewController {
  
  @IBOutlet weak var salaryTextField: UITextField!
  @IBOutlet weak var deductionsTableView: UITableView!
  @IBOutlet weak var incomeTableView: UITableView!
  @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var deductionsTableViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var incomeTableViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var contentView: UIView!
  
  //MARK: Variables
  
  var isNightShiftOn: Bool = false
  var rows = [String]()
  var rowCount = 0
  var incomeRows = [String]()
  var incomeRowCount = 0
  
  //MARK: View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareTableView(for: deductionsTableView)
    prepareTableView(for: incomeTableView)
    prepareTextFields(salaryTextField)
    addToolbarOnKeyboard(salaryTextField, withText: "Salario Mensual")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(SalaryViewController.checkDynamicTypeChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(SalaryViewController.keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(SalaryViewController.keyboardDidDisappear(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(SalaryViewController.textFieldChanged), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  //MARK: Functions that are being observed
  
  func textFieldChanged() {
    if let salaryFromView = salaryTextField.text, salaryTextField.text != "" {
      
      let cleanString = salaryFromView.replacingOccurrences(of: ",", with: "")
      let number = NSDecimalNumber(string: cleanString)
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      
      var addNumber: NSDecimalNumber = 0.0
      addNumber = addNumber.adding(number)
      
      if let formattedNumber = formatter.string(from: addNumber) {
        salaryTextField.text = formattedNumber
      }
      
    }
  }
  
  func keyboardWasShown(_ notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 60, right: 0)
      scrollView.contentInset = contentInsets
    }
  }
  
  func keyboardDidDisappear(_ notification: NSNotification) {
    let contentInsets = UIEdgeInsets.zero
    
    UIView.animate(withDuration: 0.4) { 
      self.scrollView.contentInset = contentInsets
    }
    
    let point = CGPoint(x: 0, y: 0)
    scrollView.setContentOffset(point, animated: true)
  }
  
  func checkDynamicTypeChange () {
    salaryTextField.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
  }
  
  //MARK: Segues
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let identifier = segue.identifier {
      
      switch identifier {
        
      case Segue.showResults.rawValue:
        if let destinationVC = segue.destination as? ResultsViewController {
          if let introducedSalary = salaryTextField.text , salaryTextField.text != "" {
            let cleanString = introducedSalary.replacingOccurrences(of: ",", with: "")
            let salary = NSDecimalNumber(string: cleanString)
            let customDeductions = prepareCustomDeductions()
            let customIncomes = prepareCustomIncomes()
            let payroll = Payroll(withSalary: salary,
                                  andShift: isNightShiftOn,
                                  andDeductions: customDeductions,
                                  andIncomes: customIncomes)

            destinationVC.payroll = payroll
            
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
    
    if identifier == "showSettings" {
      return shouldPerformSegue
    }
    
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
    
    for (index, _) in incomeRows.enumerated() {
      let indexPath = IndexPath(row: index, section: 0)
      let cell = incomeTableView.cellForRow(at: indexPath) as! DeductionTableViewCell
      
      if cell.deductionNameTextField.text == "" || cell.deductionAmountTextField.text == "" {
        let alert = UIAlertController(title: "Oh no!", message: "Te falta por completar ingresos :(", preferredStyle: UIAlertControllerStyle.alert)
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
  
  //MARK: Internal Functions
  
  fileprivate func prepareCustomDeductions() -> [Deduction] {
    var deductions = [Deduction]()
    
    //TODO: Need to handle nil percentages.
    
    for (index, _) in rows.enumerated() {
      let indexPath = IndexPath(row: index, section: 0)
      let cell = deductionsTableView.cellForRow(at: indexPath) as! DeductionTableViewCell
      let deduction = Deduction(name: cell.deductionNameTextField.text!,
                                amount: NSDecimalNumber(string: cell.deductionAmountTextField.text!),
                                percentage: nil,
                                frequency: .monthly,
                                type: .custom,
                                appliesForISR: false)
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
                          amount: NSDecimalNumber(string: cell.deductionAmountTextField.text!),
                          appliesForISR: false)
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


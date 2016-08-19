import UIKit

private enum Segue: String {
  case showResults
}

class SalaryViewController: UIViewController {
  
  @IBOutlet weak var salaryTextField: UITextField!
  @IBOutlet weak var dailyLabel: UILabel!
  @IBOutlet weak var holidayLabel: UILabel!
  @IBOutlet weak var dailyTextField: UITextField!
  @IBOutlet weak var holidayTextField: UITextField!
  
  private var extraHours: [String: NSDecimalNumber] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareGestureRecognizer()
    holidayTextField.delegate = self
    dailyTextField.delegate = self
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    allTextFieldsResignFirstResponder()
    
    if let identifier = segue.identifier {
      switch identifier {
        
      case Segue.showResults.rawValue:
        if let destinationVC = segue.destinationViewController as? ResultsViewController {
          if let introducedSalary = salaryTextField.text where salaryTextField.text != "" {
            let salary = NSDecimalNumber(string: introducedSalary)
            var salaryViewModel = SalaryViewModel()
            getExtraHoursFromTextFields()
            
            if extraHours.isEmpty {
              salaryViewModel = SalaryViewModel(salary: salary)
            } else {
              salaryViewModel = SalaryViewModel(salary: salary, andExtraHours: extraHours)
            }
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
    dailyTextField.resignFirstResponder()
    holidayTextField.resignFirstResponder()
  }
  
  private func getExtraHoursFromTextFields() {
    if let dailyHours = dailyTextField.text where dailyTextField.text != "" {
      let dailyHoursStringToNumber = NSDecimalNumber(string: dailyHours)
      extraHours.updateValue(dailyHoursStringToNumber, forKey: "Daily")
    }
    
    if let holidayHours = holidayTextField.text where holidayTextField.text != "" {
      let holidayHoursStringToNumber = NSDecimalNumber(string: holidayHours)
      extraHours.updateValue(holidayHoursStringToNumber, forKey: "Holiday")
    }
  }
  
}

extension SalaryViewController: UITextFieldDelegate {
  func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    
    if dailyTextField.text!.isEmpty {
      extraHours.removeValueForKey("Daily")
    }
    
    if holidayTextField.text!.isEmpty {
      extraHours.removeValueForKey("Holiday")
    }
    
    return true
  }
}

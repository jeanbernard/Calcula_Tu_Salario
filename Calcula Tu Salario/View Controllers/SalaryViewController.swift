import UIKit

private enum Segue: String {
  case showExtraHours
  case showResults
}

class SalaryViewController: UIViewController, ExtraHoursDelegate {
  
  @IBOutlet weak var salaryTextField: UITextField!
  @IBOutlet weak var diurnasTextLabel: UILabel!
  @IBOutlet weak var nocturnasTextLabel: UILabel!
  @IBOutlet weak var feriadasTextLabel: UILabel!
  
  @IBOutlet weak var diurnasResultLabel: UILabel!
  @IBOutlet weak var nocturnasResultLabel: UILabel!
  @IBOutlet weak var feriadasResultLabel: UILabel!
  
  var extraHours: [String: NSDecimalNumber] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareGestureRecognizer()
    textVisibility(forLabel: diurnasTextLabel, withResult: diurnasResultLabel)
    textVisibility(forLabel: nocturnasTextLabel, withResult: nocturnasResultLabel)
    textVisibility(forLabel: feriadasTextLabel, withResult: feriadasResultLabel)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if let identifier = segue.identifier {
      switch identifier {
        
      case Segue.showExtraHours.rawValue:
        if let destinationNavCon = segue.destinationViewController as? UINavigationController {
          if let extraHoursVC = destinationNavCon.visibleViewController as? ExtraHoursViewController {
            extraHoursVC.delegate = self
          }
        }
        
      case Segue.showResults.rawValue:
        if let destinationVC = segue.destinationViewController as? ResultsViewController {
          if let introducedSalary = salaryTextField.text where salaryTextField.text != "" {
            let salary = NSDecimalNumber(string: introducedSalary)
            var salaryViewModel = SalaryViewModel()
            
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
  
  func userEnteredDaytimeHours(hours: String) {
    diurnasResultLabel.text = hours
    textVisibility(forLabel: diurnasTextLabel, withResult: diurnasResultLabel)
    let hoursStringToNumber = NSDecimalNumber(string: hours)
    extraHours.updateValue(hoursStringToNumber, forKey: "Daily")
  }
  
  func userEnteredNighttimeHours(hours: String) {
    nocturnasResultLabel.text = hours
    textVisibility(forLabel: nocturnasTextLabel, withResult: nocturnasResultLabel)
    let hoursStringToNumber = NSDecimalNumber(string: hours)
    extraHours.updateValue(hoursStringToNumber, forKey: "Nightly")
  }
  
  func userEntetedHolidayHours(hours: String) {
    feriadasResultLabel.text = hours
    textVisibility(forLabel: feriadasTextLabel, withResult: feriadasResultLabel)
    let hoursStringToNumber = NSDecimalNumber(string: hours)
    extraHours.updateValue(hoursStringToNumber, forKey: "Holiday")
  }
  
  private func prepareGestureRecognizer() {
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SalaryViewController.tappedOut)))
  }
  
  @objc private func tappedOut() {
    salaryTextField.resignFirstResponder()
  }
  
  private func textVisibility(forLabel label: UILabel, withResult result: UILabel) {
    
    let isResultLabelEmpty = result.text == " "
    let isLabelHidden = !result.hidden
    
    if isResultLabelEmpty && isLabelHidden {
      result.hidden = true
      label.hidden = true
    }
    else {
      result.hidden = false
      label.hidden = false
    }
  }
  
}

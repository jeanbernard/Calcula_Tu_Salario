import UIKit

protocol ExtraHoursDelegate: class {
  func userEnteredDaytimeHours(hours: String)
  func userEnteredNighttimeHours(hours: String)
  func userEntetedHolidayHours(hours: String)
}

class ExtraHoursViewController: UIViewController {
  
  weak var delegate: ExtraHoursDelegate?
  
  @IBOutlet weak var daytimeTextLabel: UITextField!
  @IBOutlet weak var nighttimeTextLabel: UITextField!
  @IBOutlet weak var holidayTextLabel: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareGestureRecognizer()
  }
  
  @IBAction func dismissModalViewButtonPressed(sender: UIBarButtonItem) {
    
    if let daytimeHours = daytimeTextLabel.text where daytimeTextLabel.text != "" {
      delegate?.userEnteredDaytimeHours(daytimeHours)
    }
    
    if let nighttimeHours = nighttimeTextLabel.text where nighttimeTextLabel.text != "" {
      delegate?.userEnteredNighttimeHours(nighttimeHours)
    }
    
    if let holidayHours = holidayTextLabel.text where holidayTextLabel.text != "" {
      delegate?.userEntetedHolidayHours(holidayHours)
    }
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  private func prepareGestureRecognizer() {
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ExtraHoursViewController.tappedOut)))
  }
  
  @objc private func tappedOut() {
    daytimeTextLabel.resignFirstResponder()
    nighttimeTextLabel.resignFirstResponder()
    holidayTextLabel.resignFirstResponder()
  }
  
}

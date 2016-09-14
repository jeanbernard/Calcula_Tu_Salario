import UIKit

protocol SettingsDelegate: class {
  func isNightShiftEnabled(_ switchButton: UISwitch)
}

class SettingsTableViewController: UITableViewController {
  
  @IBOutlet weak var nightShiftSwitch: UISwitch!
  weak var delegate: SettingsDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let userDefaults = UserDefaults.standard.bool(forKey: "NightSwitch")
    nightShiftSwitch.isOn = userDefaults
  }
  
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    UserDefaults.standard.set(nightShiftSwitch.isOn, forKey: "NightSwitch")
    delegate?.isNightShiftEnabled(nightShiftSwitch)
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
}

import UIKit

protocol SettingsDelegate: class {
  func isNightShiftEnabled(switchButton: UISwitch)
}

class SettingsTableViewController: UITableViewController {
  
  @IBOutlet weak var nightShiftSwitch: UISwitch!
  weak var delegate: SettingsDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let userDefaults = NSUserDefaults.standardUserDefaults().boolForKey("NightSwitch")
    nightShiftSwitch.on = userDefaults
  }
  
  
  @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
    NSUserDefaults.standardUserDefaults().setBool(nightShiftSwitch.on, forKey: "NightSwitch")
    delegate?.isNightShiftEnabled(nightShiftSwitch)
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
}

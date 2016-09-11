import UIKit

extension SalaryViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 1 {
      rows.append("")
      
      let insertToIndexPath = NSIndexPath(forRow: rowCount, inSection: 0)
      tableView.beginUpdates()
      tableView.insertRowsAtIndexPaths([insertToIndexPath], withRowAnimation: .Bottom)
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      tableView.endUpdates()
      
      rowCount += 1
      let deductionCell = tableView.cellForRowAtIndexPath(insertToIndexPath) as! DeductionTableViewCell
      addToolbarOnKeyboard(deductionCell.deductionNameTextField, withText: "Nombre de la deducción")
      addToolbarOnKeyboard(deductionCell.deductionAmountTextField, withText: "Monto de la deducción")
      deductionCell.deductionNameTextField.autocorrectionType = .No
      deductionCell.deductionNameTextField.becomeFirstResponder()
    }
    
    if tableView.contentSize.height > 80 {
      contentViewHeightConstraint.constant += 40
    }
    
  }
  
  
  
  func addToolbarOnKeyboard(textField: UITextField, withText text: String) {
    let doneToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
    doneToolbar.barStyle = UIBarStyle.Default
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    
    let deductionAmountLabel = UILabel().prepareForToolbar(withText: text)
    
    let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(SalaryViewController.doneButtonAction))
    
    let barButton = UIBarButtonItem(customView: deductionAmountLabel)
    
    var items: [UIBarButtonItem] = []
    items.append(flexSpace)
    items.append(barButton)
    items.append(flexSpace)
    items.append(done)
    
    doneToolbar.items = items
    doneToolbar.sizeToFit()
    
    textField.inputAccessoryView = doneToolbar
  }
  
  func doneButtonAction() {
    view.endEditing(true)
  }
  
}
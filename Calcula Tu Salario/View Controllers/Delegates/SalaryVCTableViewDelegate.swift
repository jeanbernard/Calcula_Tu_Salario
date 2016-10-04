import UIKit

extension SalaryViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if tableView == deductionsTableView {
      
      if (indexPath as NSIndexPath).section == 1 {
        rows.append("")
        
        let insertToIndexPath = IndexPath(row: rowCount, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [insertToIndexPath], with: .bottom)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
        
        rowCount += 1
        let deductionCell = tableView.cellForRow(at: insertToIndexPath) as! DeductionTableViewCell
        addToolbarOnKeyboard(deductionCell.deductionNameTextField, withText: "Nombre de la deducción")
        addToolbarOnKeyboard(deductionCell.deductionAmountTextField, withText: "Monto de la deducción")
        deductionCell.deductionNameTextField.autocorrectionType = .no
        deductionCell.deductionNameTextField.becomeFirstResponder()
        
        contentViewHeightConstraint.constant += 44
        deductionsTableViewHeightConstraint.constant += 44
        tableView.contentSize.height = deductionsTableViewHeightConstraint.constant
        
        UIView.animate(withDuration: 0.4, animations: {
          self.view.layoutIfNeeded()
        })
      }
      
    }
      
    else if tableView == incomeTableView {
      if (indexPath as NSIndexPath).section == 1 {
        incomeRows.append("")
        
        let insertToIndexPath = IndexPath(row: incomeRowCount, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [insertToIndexPath], with: .bottom)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
        
        incomeRowCount += 1
        let deductionCell = tableView.cellForRow(at: insertToIndexPath) as! DeductionTableViewCell
        addToolbarOnKeyboard(deductionCell.deductionNameTextField, withText: "Nombre del ingreso")
        addToolbarOnKeyboard(deductionCell.deductionAmountTextField, withText: "Monto del ingreso")
        deductionCell.deductionNameTextField.autocorrectionType = .no
        deductionCell.deductionNameTextField.becomeFirstResponder()
        
        contentViewHeightConstraint.constant += 44
        incomeTableViewHeightConstraint.constant += 44
        tableView.contentSize.height = incomeTableViewHeightConstraint.constant
        
        UIView.animate(withDuration: 0.4, animations: {
          self.view.layoutIfNeeded()
        })
      }
      
      
    }
    
  }
  
  func addToolbarOnKeyboard(_ textField: UITextField, withText text: String) {
    let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
    doneToolbar.barStyle = UIBarStyle.default
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    let deductionAmountLabel = UILabel().prepareForToolbar(withText: text)
    
    let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(SalaryViewController.doneButtonAction))
    
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

import UIKit

extension SalaryViewController: UITableViewDataSource {
  
  fileprivate enum CellIdentifiers {
    static let deduction = "DeductionCell"
    static let createDeduction = "CreateDeductionCell"
  }
  
  //MARK: Data Source
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if (indexPath as NSIndexPath).section == 0 {
      let deductionCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.deduction) as! DeductionTableViewCell
      
      if deductionCell.deductionNameTextField.text != "" && deductionCell.deductionAmountTextField.text != "" {
        deductionCell.deductionNameTextField.text = ""
        deductionCell.deductionAmountTextField.text = ""
      }
      
      return deductionCell
    } else {
      let createDeductionCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.createDeduction)
      return createDeductionCell!
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return rows.count
    } else {
      return 1
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  //MARK: Editing
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    if (indexPath as NSIndexPath).section == 0 {
      return true
    }
    return false
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCellEditingStyle.delete {
      tableView.beginUpdates()
      
      rows.remove(at: (indexPath as NSIndexPath).row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      
      tableView.endUpdates()
      contentViewHeightConstraint.constant -= 40
      rowCount -= 1
    }
  }
  
  func prepareDeductionsTableView(_ tableView: UITableView) {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    tableView.tableHeaderView = UIView()
    tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
    tableView.alwaysBounceVertical = false
    tableView.allowsMultipleSelectionDuringEditing = false
    tableView.isEditing = true
    tableView.allowsSelectionDuringEditing = true
  }
}

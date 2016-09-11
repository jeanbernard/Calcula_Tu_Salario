import UIKit

extension SalaryViewController: UITableViewDataSource {
  
  private enum CellIdentifiers {
    static let deduction = "DeductionCell"
    static let createDeduction = "CreateDeductionCell"
  }
  
  //MARK: Data Source
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let deductionCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.deduction) as! DeductionTableViewCell
      
      if deductionCell.deductionNameTextField.text != "" && deductionCell.deductionAmountTextField.text != "" {
        deductionCell.deductionNameTextField.text = ""
        deductionCell.deductionAmountTextField.text = ""
      }
      
      return deductionCell
    } else {
      let createDeductionCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.createDeduction)
      return createDeductionCell!
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return rows.count
    } else {
      return 1
    }
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  //MARK: Editing
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    if indexPath.section == 0 {
      return true
    }
    return false
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == UITableViewCellEditingStyle.Delete {
      tableView.beginUpdates()
      
      rows.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      
      tableView.endUpdates()
      contentViewHeightConstraint.constant -= 40
      rowCount -= 1
    }
  }
  
  func prepareDeductionsTableView(tableView: UITableView) {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    tableView.tableHeaderView = UIView()
    tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    tableView.alwaysBounceVertical = false
    tableView.allowsMultipleSelectionDuringEditing = false
    tableView.editing = true
    tableView.allowsSelectionDuringEditing = true
  }
}
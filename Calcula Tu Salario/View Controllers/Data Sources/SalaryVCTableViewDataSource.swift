import UIKit

extension SalaryViewController: UITableViewDataSource {
  
  fileprivate enum CellIdentifiers {
    static let deduction = "DeductionCell"
    static let createDeduction = "CreateDeductionCell"
  }
  
  //MARK: Data Source
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if tableView == deductionsTableView {
      if (indexPath as NSIndexPath).section == 0 {
        let deductionCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.deduction) as! DeductionTableViewCell
        
        if deductionCell.deductionNameTextField.text != "" && deductionCell.deductionAmountTextField.text != "" {
          deductionCell.deductionNameTextField.text = ""
          deductionCell.deductionAmountTextField.text = ""
        }
        
        prepareTextFields(deductionCell.deductionAmountTextField)
        
        return deductionCell
      } else {
        let createDeductionCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.createDeduction)
        return createDeductionCell!
      }
    }
    
    else if tableView == incomeTableView {
      
      if (indexPath as NSIndexPath).section == 0 {
        let deductionCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.deduction) as! DeductionTableViewCell
        
        if deductionCell.deductionNameTextField.text != "" && deductionCell.deductionAmountTextField.text != "" {
          deductionCell.deductionNameTextField.text = ""
          deductionCell.deductionAmountTextField.text = ""
        }
  
        prepareTextFields(deductionCell.deductionAmountTextField)
        
        return deductionCell
      } else {
        let createDeductionCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.createDeduction)
        return createDeductionCell!
      }
    }
    return UITableViewCell()
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      
      if tableView == deductionsTableView {
        return rows.count
      }
      
      else if tableView == incomeTableView {
        return incomeRows.count
      }
      
    }
    return 1
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
      
      if tableView == deductionsTableView {
        tableView.beginUpdates()
        
        rows.remove(at: (indexPath as NSIndexPath).row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
        
        contentViewHeightConstraint.constant -= 44
        deductionsTableViewHeightConstraint.constant -= 44
        tableView.contentSize.height = deductionsTableViewHeightConstraint.constant
        
        UIView.animate(withDuration: 0.4, animations: {
          self.view.layoutIfNeeded()
        })
        
        rowCount -= 1
        
      }
      
      else if tableView == incomeTableView {
        tableView.beginUpdates()
        
        incomeRows.remove(at: (indexPath as NSIndexPath).row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
        contentViewHeightConstraint.constant -= 44
        incomeTableViewHeightConstraint.constant -= 44
        tableView.contentSize.height = incomeTableViewHeightConstraint.constant
        
        UIView.animate(withDuration: 0.4, animations: {
          self.view.layoutIfNeeded()
        })

        incomeRowCount -= 1
      }
      
    }
    
    
  }
  
  func prepareTableView(for tableView: UITableView) {
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

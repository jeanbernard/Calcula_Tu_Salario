import UIKit

extension SalaryViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let returnKey = ""
    let maxCharacterCount = 7
    
    if string == returnKey {
      return true
    }

    if let characterCount = textField.text?.characters.count {
      if characterCount >= maxCharacterCount {
        return false
      }
    }
    
    return true
  }
  
  func prepareTextFields(_ textField: UITextField) {
    textField.delegate = self
  }

}

import UIKit

extension UILabel {
  func prepareForToolbar(withText text: String) -> UILabel {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    label.text = text
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightUltraLight)
    return label
  }
}

extension UITextField {
  override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return false
  }
}

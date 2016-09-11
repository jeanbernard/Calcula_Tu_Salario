import UIKit

extension UILabel {
  func prepareForToolbar(withText text: String) -> UILabel {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    label.text = text
    label.textAlignment = .Center
    label.adjustsFontSizeToFitWidth = true
    label.font = UIFont.systemFontOfSize(14, weight: UIFontWeightUltraLight)
    return label
  }
}
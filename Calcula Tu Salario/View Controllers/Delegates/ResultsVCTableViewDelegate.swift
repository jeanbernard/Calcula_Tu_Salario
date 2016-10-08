import UIKit

extension ResultsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    
    if let view = view as? UITableViewHeaderFooterView {
      view.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightSemibold)
      //view.textLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
      view.tintColor = UIColor.clear
      view.textLabel?.text = view.textLabel?.text?.capitalized
    }
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
}




import UIKit

extension ResultsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    
    if let view = view as? UITableViewHeaderFooterView {
      view.textLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFontWeightBold)
      //view.textLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
      view.tintColor = UIColor.clear
    }
    
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
}




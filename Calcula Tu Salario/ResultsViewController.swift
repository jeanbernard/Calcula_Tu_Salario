import UIKit

class ResultsViewController: UIViewController {
  
  var result: NSDecimalNumber = 0.0
  
  @IBOutlet weak var resultLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "$\(result)"
    }
}

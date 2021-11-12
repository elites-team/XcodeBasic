import UIKit

class SecondViewController: UIViewController {
    
//    var resultArray:[Double] = []
//    var sum:Double = 0
    var ani:Any?
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "item") != nil {
            let resultArray = userDefaults.object(forKey: "item") as! [Double]
            
            let sum = resultArray.reduce(0) { (num1:Double, num2:Double) -> (Double) in
                return num1 + num2
            }
            
            resultLabel.text = String(format: "%.0f", sum)
        }
    }
}

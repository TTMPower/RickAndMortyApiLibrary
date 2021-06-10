
import UIKit

class PresentViewController: UIViewController {
    var myTimer = Timer()
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var activityOutlet: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityOutlet.startAnimating()
        createTimer()
    }
    
    func createTimer(){
        myTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(hideView), userInfo: nil, repeats: false)
    }
    
    @objc func hideView() {
        mainView.isHidden = true
        performSegue(withIdentifier: "presentCell", sender: self)
    }

}

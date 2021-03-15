

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailScreenViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self)) as! ViewController
        detailScreenViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(detailScreenViewController, animated: true)
    }

    
}

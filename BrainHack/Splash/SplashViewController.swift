import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
    
    var logoIsHidden: Bool = false
    var textImage: UIImage?
    
    static let logoImageBig: UIImage = UIImage(named: "splash-logo-big")!

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textImageView.image = textImage
        logoImageView.isHidden = logoIsHidden
    }
    
}

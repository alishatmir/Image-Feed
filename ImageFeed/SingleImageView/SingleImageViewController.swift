import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage?
    
    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        imageView.image = image
    }
}

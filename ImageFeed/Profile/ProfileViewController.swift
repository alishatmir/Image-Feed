import UIKit

final class ProfileViewController: UITableViewCell {
    
    @IBOutlet weak var userPhoto: UIImageView!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    @IBAction func didTapLogoutButton(_ sender: Any) {
    }
}

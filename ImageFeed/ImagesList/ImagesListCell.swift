import UIKit

final class ImagesListCell: UITableViewCell {
    @IBOutlet private var cellImage: UIImageView!
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var dateLabel: UILabel!
    
    static let reuseIdentifier = "ImagesListCell"
    
    func configure(imageName: String, date: String, isLiked: Bool) {
        guard let image = UIImage(named: imageName) else { return }
        selectionStyle = .none
        cellImage.image = image
        dateLabel.text = date
        
        let likeImage = isLiked ? UIImage(named: "likeActive") : UIImage(named: "likeNoActive")
        likeButton.setImage(likeImage, for: .normal)
    }
}

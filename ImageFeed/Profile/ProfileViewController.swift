import UIKit

final class ProfileViewController: UIViewController {
    
    lazy private var userPhotoImageView: UIImageView = {
        let profileImage = UIImage(systemName: "person.crop.circle.fill")
        let imageView = UIImageView(image: profileImage)
        let image = UIImage(named: "userPhoto")
        imageView.image = image
        imageView.backgroundColor = .ypBlack
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.text = "Екатерина Новикова"
        loginLabel.textColor = .ypWhite
        let font = UIFont.systemFont(ofSize: 23, weight: .bold)
        loginLabel.font = font
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        return loginLabel
    }()
    
    lazy private var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.text = "@ekaterina_nov"
        emailLabel.textColor = .ypGray
        let font = UIFont.systemFont(ofSize: 13, weight: .regular)
        emailLabel.font = font
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        return emailLabel
    }()
    
    lazy private var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Hello"
        descriptionLabel.textColor = .ypWhite
        let font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.font = font
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    lazy private var forwardButton: UIButton = {
        let forwardButton = UIButton(type: .custom)
        forwardButton.setImage(.init(resource: .exit), for: .normal)
        forwardButton.addTarget(
            self,
            action: #selector(didTapLogoutButton),
            for: .touchUpInside
        )
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.tintColor = UIColor.ypRed
        return forwardButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUserPhotoImageView()
        addLoginLabel()
        addEmailLabel()
        addDescriptionLabel()
        addForwardButton()
    }
    
    private func addUserPhotoImageView() {
        view.addSubview(userPhotoImageView)
        
        NSLayoutConstraint.activate([
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 70),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 70),
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    private func addLoginLabel(){
        view.addSubview(loginLabel)
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 8),
            loginLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.leadingAnchor)
        ])
    }
    
    private func addEmailLabel() {
        view.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.leadingAnchor)
        ])
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.leadingAnchor)
        ])
    }
    
    private func addForwardButton() {
        view.addSubview(forwardButton)
        
        NSLayoutConstraint.activate([
            forwardButton.centerYAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            forwardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forwardButton.widthAnchor.constraint(equalToConstant: 44),
            forwardButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc
    private func didTapLogoutButton() {
        
    }
}

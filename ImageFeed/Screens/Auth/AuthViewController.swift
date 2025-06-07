import UIKit

final class AuthViewController: UIViewController {
    
    lazy private var logoOfUnsplashImageView: UIImageView = {
        let logoOfUnsplash = UIImage(resource: .logo)
        let imageView = UIImageView(image: logoOfUnsplash)
        imageView.backgroundColor = .ypBlack
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var enterButton: UIButton = {
        let enterButton = UIButton(type: .custom)
        enterButton.backgroundColor = .ypWhite
        enterButton.setTitle("Войти", for: .normal)
        let font = UIFont.systemFont(ofSize: 17, weight: .bold)
        enterButton.setTitleColor(.ypBlack, for: .normal)
        enterButton.titleLabel?.font = font
        enterButton.layer.cornerRadius = 16
        enterButton.layer.masksToBounds = true
        enterButton.addTarget(
            self,
            action: #selector(didTapEnterButton),
            for: .touchUpInside
        )
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        return enterButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlack
        addLogoOfUnsplashImageView()
        addEnterButton()
        configureBackButton()
    }
    
    private func addLogoOfUnsplashImageView() {
        view.addSubview(logoOfUnsplashImageView)
        
        NSLayoutConstraint.activate([
            logoOfUnsplashImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoOfUnsplashImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
    }
    
    private func addEnterButton() {
        view.addSubview(enterButton)
        
        NSLayoutConstraint.activate([
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -124),
            enterButton.widthAnchor.constraint(equalToConstant: 343),
            enterButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc
    private func didTapEnterButton() {
        let vc = WebViewViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = .init(resource: .backward)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = .init(resource: .backward)
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem?.tintColor = .ypBlack
    }
    
    private func navigateToAuthorizedZone() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let nc = TabBarController()
        window.rootViewController = nc
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        OAuth2Service.shared.fetchOAuthToken(code) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                OAuth2TokenStorage().token = response
                navigateToAuthorizedZone()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
}

import UIKit

final class SingleImageViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var imageView = UIImageView()
    
    lazy var backwardButton: UIButton = {
        let backwardButton = UIButton(type: .custom)
        backwardButton.setImage(.init(resource: .backward), for: .normal)
        backwardButton.addTarget(
            self,
            action: #selector(didTapBackwardButton),
            for: .touchUpInside
        )
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        return backwardButton
    }()
    
    lazy var shareButton: UIButton = {
        let sharingButton = UIButton(type: .custom)
        sharingButton.setImage(.init(resource: .sharing), for: .normal)
        sharingButton.addTarget(
            self,
            action: #selector(didTapShareButton),
            for: .touchUpInside
        )
        sharingButton.translatesAutoresizingMaskIntoConstraints = false
        sharingButton.tintColor = UIColor.ypRed
        return sharingButton
    }()
    
    var image: UIImage? {
        didSet {
            guard isViewLoaded, let image else { return }
            
            imageView.image = image
            imageView.frame.size = image.size
            imageView.translatesAutoresizingMaskIntoConstraints = false
            rescaleAndCenterImageInScrollView(image: image)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        guard let image = image else { return }
        imageView.frame.size = image.size
        
        createScrollView()
        scrollView.delegate = self
        createButtons()
        rescaleAndCenterImageInScrollView(image: image)
    }
    
    func createScrollView() {
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.maximumZoomScale = 1.25
        scrollView.minimumZoomScale = 0.1
        scrollView.addSubview(imageView)
        scrollView.contentSize = self.imageView.bounds.size
        self.view.addSubview(scrollView)
        view.backgroundColor = .ypBlack
    }
    
    func createButtons() {
        view.addSubview(backwardButton)
        view.addSubview(shareButton)
        NSLayoutConstraint.activate([
            backwardButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 9),
            backwardButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            backwardButton.widthAnchor.constraint(equalToConstant: 24),
            backwardButton.heightAnchor.constraint(equalToConstant: 24),
            
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -17),
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 50),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func rescaleAndCenterImageInScrollView(image: UIImage) {
        let maximumZoomScale = scrollView.maximumZoomScale
        let minimumZoomScale = scrollView.minimumZoomScale
        
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let hScale = visibleRectSize.width / image.size.width
        let vScale = visibleRectSize.height / image.size.height
        let scale = min(maximumZoomScale, max(minimumZoomScale, min(hScale, vScale)))
        self.scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    @objc func didTapBackwardButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapShareButton() {
        guard let image else { return }
        let sharing = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        present(sharing, animated: true, completion: nil)
    }
}
extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming( in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

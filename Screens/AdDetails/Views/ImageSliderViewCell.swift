import UIKit

internal class ImageSliderViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {

    internal var imageUrl: URL? {
        didSet {
            imageView.kf.setImage(with: self.imageUrl)
        }
    }

    internal var zoomEnabled: Bool = false {
        didSet {
            imageView.isUserInteractionEnabled = zoomEnabled
        }
    }

    internal lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Asset.backgroundColor.color
        return imageView
    }()

    internal override init(frame: CGRect) {
        super.init(frame: frame)

        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
        pinch.delegate = self

        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(pinch)

        self.commonInit()
    }

    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var isZooming = false

    @objc private func pinch(sender: UIPinchGestureRecognizer) {
        guard alpha == 1.0 else {return}
        
        if sender.state == .began {
            let currentScale = self.imageView.frame.size.width / self.imageView.bounds.size.width
            
            let newScale = currentScale * sender.scale
            if newScale > 1 {
                self.isZooming = true
                self.superview?.bringSubviewToFront(self)
            }
        } else if sender.state == .changed {
            guard let view = sender.view else {return}
            let pincherCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,
                                        y: sender.location(in: view).y - view.bounds.midY)
            let transform = view.transform.translatedBy(x: pincherCenter.x, y: pincherCenter.y)
                .scaledBy(x: sender.scale, y: sender.scale)
                .translatedBy(x: -pincherCenter.x, y: -pincherCenter.y)
            let currentScale = self.imageView.frame.size.width / self.imageView.bounds.size.width
            var newScale = currentScale * sender.scale
            if newScale < 1 {
                newScale = 1
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                self.imageView.transform = transform
                sender.scale = 1
            } else {
                view.transform = transform
                sender.scale = 1
            }
        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.transform = CGAffineTransform.identity
            }, completion: { _ in
                self.isZooming = false
            })
        }
    }

    private func commonInit() {
        backgroundColor = Asset.backgroundColor.color
        self.contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

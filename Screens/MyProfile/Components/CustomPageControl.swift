import UIKit
import SnapKit

internal class CustomPageControl: UIPageControl {
    
    fileprivate let activeDotFrame = CGRect(origin: .zero, size: CGSize(width: 8, height: 8))
    fileprivate let inactiveDotFrame = CGRect(origin: .zero, size: CGSize(width: 5, height: 5))
    fileprivate let dotPadding: CGFloat = 9
    
    internal init() {
        super.init(frame: .zero)
        if #available(iOS 14.0, *) {
            backgroundStyle = .minimal
            allowsContinuousInteraction = false
        }
        frame.size = size(forNumberOfPages: 3)
        hidesForSinglePage = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var activeImageView: UIImageView = {
        let view = UIImageView(frame: self.activeDotFrame)
        view.backgroundColor = .red
        view.alpha = 1
        view.isOpaque = false
        view.setNeedsDisplay()
        view.layoutIfNeeded()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var inactiveImageView: UIImageView = {
        let view = UIImageView(frame: self.inactiveDotFrame)
        view.backgroundColor = .red
        view.alpha = 1
        view.isOpaque = false
        view.setNeedsDisplay()
        view.layoutIfNeeded()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.inactiveImageView.image = Asset.activePageItem.image
        self.activeImageView.image = Asset.innactivePageItem.image
        self.tintColor = .clear
        self.pageIndicatorTintColor = .clear
        self.currentPageIndicatorTintColor = .clear
        self.isUserInteractionEnabled = false
        self.clipsToBounds = false
    }
    
    override var numberOfPages: Int {
        didSet {
            self.updateDots()
        }
    }
    
    override var currentPage: Int {
        didSet {
            self.updateDots()
        }
    }
    
    private func updateDots() {
        var dotOriginY: CGFloat = 0
        
        for index in 0..<self.subviews.count {
            let subview = self.subviews[index]
            let dot: UIImageView = imageViewForSubview(view: subview)
            
            if index == self.currentPage {
                dot.image = activeImageView.image
                dot.frame = activeDotFrame
            } else {
                dot.image = inactiveImageView.image
                dot.frame = inactiveDotFrame
            }
            
            dot.frame.origin.x = dotOriginY
            dotOriginY = dot.frame.origin.x + dot.frame.size.width + self.dotPadding
            
            if index == self.subviews.count - 1 {
                dotOriginY -= self.dotPadding
            }
        }
        
        self.updateConstraints()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    private func imageViewForSubview(view: UIView) -> UIImageView {
        var dot: UIImageView!
        
        if let imgView = view as? UIImageView {
            dot = imgView
        } else {
            for subview: UIView in view.subviews {
                if let subimgView = subview as? UIImageView {
                    dot = subimgView
                }
            }
            
            if dot == nil {
                dot = UIImageView(frame: .zero)
                view.addSubview(dot!)
            }
        }
        
        dot?.contentMode = .scaleAspectFit
        return dot!
    }
}

import UIKit
import SnapKit

internal final class AdScrollViewElement: UIScrollView {
    internal lazy var imageArray: [UIImage?] = .init()
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        onConfigureView()
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func onConfigureView() {
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        layer.cornerRadius = 8
    }
    
    internal func setupImages(imageArray: [UIImageView], size: CGFloat) {
        for index in 0..<imageArray.count {
            let imageView = imageArray[index]
            let xPosition = size * CGFloat(index)
            imageView.frame = CGRect(x: xPosition, y: 0, width: size, height: size)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            contentSize.width = size * CGFloat(index + 1)
            addSubview(imageView)
        }
    }
}

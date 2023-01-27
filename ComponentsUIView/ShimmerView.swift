import Foundation
import UIKit

internal class ShimmerView: UIView {

    internal var customBlocks = [CGRect]() {
        didSet {
            subviews.forEach { subview in subview.removeFromSuperview() }
            customBlocks.forEach { frame in
                let view = SingleShimmerView(frame: frame)
                view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
                self.addSubview(view)
            }
        }
    }

    internal override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Asset.backgroundColor.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class SingleShimmerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.addSublayer(gradientLayer)
        backgroundColor = .lightGray
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var gradientColorOne: CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    private var gradientColorTwo: CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]

        return gradientLayer
    }()

    internal override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = self.bounds
    }

    internal override func didMoveToWindow() {
        super.didMoveToWindow()

        gradientLayer.removeAnimation(forKey: "shimmer")

        if self.window != nil {
            let animation = CABasicAnimation(keyPath: "locations")
            animation.fromValue = [-1.0, 0.5, 0.0]
            animation.toValue = [1.0, 1.5, 2.0]
            animation.repeatCount = .infinity
            animation.duration = 0.9
            gradientLayer.add(animation, forKey: "shimmer")
        }
    }
}

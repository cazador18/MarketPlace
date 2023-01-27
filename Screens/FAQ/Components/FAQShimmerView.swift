import Foundation
import UIKit

internal class FAQShimmerView: UIView {
    public override init(frame: CGRect) {
        super .init(frame: frame)
        onAddSubviews()
        configureShimmerView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var shimmerView = ShimmerView()

    internal override func layoutSubviews() {
        super.layoutSubviews()
        configureShimmerView()
    }

    private func configureShimmerView() {
        let rect1 = CGRect(x: 16, y: 96, width: self.frame.width - 32, height: 70)
        let rect2 = CGRect(x: 16, y: rect1.maxY + 16, width: self.frame.width - 32, height: 70)
        let rect3 = CGRect(x: 16, y: rect2.maxY + 16, width: self.frame.width - 32, height: 70)
        let rect4 = CGRect(x: 16, y: rect3.maxY + 16, width: self.frame.width - 32, height: 70)
        let rect5 = CGRect(x: 16, y: rect4.maxY + 16, width: self.frame.width - 32, height: 70)
        let rect6 =  CGRect(x: 16, y: rect5.maxY + 16, width: self.frame.width - 32, height: 70)
        let rect7 = CGRect(x: 16, y: rect6.maxY + 16, width: self.frame.width - 32, height: 70)
        let rect8 = CGRect(x: 16, y: rect7.maxY + 16, width: self.frame.width - 32, height: 70)
        shimmerView.customBlocks = [rect1, rect2, rect3, rect4, rect5, rect6, rect7, rect8]
        shimmerView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: rect7.maxY + 8)
    }
    
    private func onAddSubviews() {
        addSubview(shimmerView)
    }
}

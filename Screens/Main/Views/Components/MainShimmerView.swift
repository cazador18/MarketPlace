import Foundation
import UIKit

internal class MainShimmerView: UIView {
    public override init(frame: CGRect) {
        super .init(frame: frame)
        onAddSubviews()
        configureShimmerView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let shimmerView = ShimmerView()
    private let shimmerView2 = ShimmerView()
    private let shimmerView3 = ShimmerView()
    private let shimmerView4 = ShimmerView()

    internal override func layoutSubviews() {
        super.layoutSubviews()
        configureShimmerView()
    }
    
    private func configureShimmerView() {
        let rect1 = CGRect(x: 8, y: 0, width: self.frame.width / 2 - 16, height: self.frame.width / 2 - 16)
        let rect2 = CGRect(x: 8, y: rect1.maxY + 8, width: 86, height: 18)
        let rect3 = CGRect(x: 8, y: rect2.maxY + 8, width: 86, height: 18)
        let rect4 = CGRect(x: 8, y: rect3.maxY + 8, width: 153, height: 32)
        let rect5 = CGRect(x: 8, y: rect4.maxY + 8, width: rect4.width, height: rect4.height)

        shimmerView.customBlocks = [rect1, rect2, rect3, rect4, rect5]
        shimmerView.frame = CGRect(x: 0,
                                   y: Int(self.safeAreaLayoutGuide.layoutFrame.minY) + 164,
                                   width: Int(self.frame.width) / 2,
                                   height: Int(rect5.maxY) + 8)
        shimmerView2.customBlocks = shimmerView.customBlocks
        shimmerView2.frame = CGRect(origin: CGPoint(x: shimmerView.frame.width,
                                                    y: self.safeAreaLayoutGuide.layoutFrame.minY + 164),
                                    size: shimmerView.frame.size)
        shimmerView3.customBlocks = shimmerView.customBlocks
        shimmerView3.frame = CGRect(origin: CGPoint(x: 0, y: shimmerView.frame.maxY),
                                   size: shimmerView.frame.size)
        shimmerView4.customBlocks = shimmerView.customBlocks
        shimmerView4.frame = CGRect(origin: CGPoint(x: shimmerView.frame.width, y: shimmerView2.frame.maxY),
                                    size: shimmerView.frame.size)
    }

    private func onAddSubviews() {
        addSubview(shimmerView)
        addSubview(shimmerView2)
        addSubview(shimmerView3)
        addSubview(shimmerView4)
    }
}

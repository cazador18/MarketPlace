import Foundation
import UIKit

class MainCategoryShimmerView: UIView {
    public override init(frame: CGRect) {
        super .init(frame: frame)
        onAddSubviews()
        configureShimmerView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let shimmerView = ShimmerView()

    internal override func layoutSubviews() {
        super.layoutSubviews()
        configureShimmerView()
    }

    private func configureShimmerView() {
        let rectWidth = 36
        let rectHeight = 36
        let rect1 = CGRect(x: 16, y: 0, width: rectWidth, height: rectHeight)
        let rect2 = CGRect(x: Int(rect1.maxX) + 32, y: 0, width: rectWidth, height: rectHeight)
        let rect3 = CGRect(x: Int(rect2.maxX) + 32, y: 0, width: rectWidth, height: rectHeight)
        let rect4 = CGRect(x: Int(rect3.maxX) + 32, y: 0, width: rectWidth, height: rectHeight)
        let rect5 = CGRect(x: Int(rect4.maxX) + 32, y: 0, width: rectWidth, height: rectHeight)
        let rect6 = CGRect(x: Int(rect5.maxX) + 32, y: 0, width: rectWidth, height: rectHeight)

        shimmerView.customBlocks = [rect1, rect2, rect3, rect4, rect5, rect6]
        shimmerView.frame = CGRect(x: 0, y: Int(self.safeAreaLayoutGuide.layoutFrame.minY + 55), width: Int(self.frame.width), height: rectHeight)
    }

    private func onAddSubviews() {
        addSubview(shimmerView)
    }

}

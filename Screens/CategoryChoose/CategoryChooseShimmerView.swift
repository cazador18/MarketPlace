import UIKit

internal class CategoryChooseShimmerView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureShimmerView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var shimmerView = ShimmerView()

    internal override func layoutSubviews() {
        super.layoutSubviews()
        onAddSubviews()
        configureShimmerView()

    }

    private func configureShimmerView() {
        let heightRect = CGFloat(44)
        let rect1 = CGRect(x: 8, y: 0,
                           width: self.frame.width - 16, height: heightRect)
        let rect2 = CGRect(x: 8, y: rect1.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect3 = CGRect(x: 8, y: rect2.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect4 = CGRect(x: 8, y: rect3.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect5 = CGRect(x: 8, y: rect4.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect6 = CGRect(x: 8, y: rect5.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect7 = CGRect(x: 8, y: rect6.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect8 = CGRect(x: 8, y: rect7.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect9 = CGRect(x: 8, y: rect8.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect10 = CGRect(x: 8, y: rect9.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect11 = CGRect(x: 8, y: rect10.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect12 = CGRect(x: 8, y: rect11.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect13 = CGRect(x: 8, y: rect12.maxY + 5, width: self.frame.width - 16, height: heightRect)
        let rect14 = CGRect(x: 8, y: rect13.maxY + 5, width: self.frame.width - 16, height: heightRect)

        shimmerView.customBlocks = [rect1, rect2, rect3, rect4, rect5, rect6, rect7, rect8, rect9, rect10, rect11, rect12, rect13, rect14]
        shimmerView.frame = CGRect(x: 0, y: self.safeAreaLayoutGuide.layoutFrame.minY + 100, width: self.frame.width, height: rect14.maxY)
    }

    private func onAddSubviews() {
        addSubview(shimmerView)
    }
}

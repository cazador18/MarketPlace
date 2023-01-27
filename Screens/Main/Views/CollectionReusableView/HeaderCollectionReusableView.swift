import UIKit
import SnapKit

internal final class HeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: Properties
    internal static let identifier = "HeaderCollectionReusableView"
    private lazy var cityLabel: UILabel = .init()
    
    // MARK: Initializers
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        onConfigureView()
        onAddSubViews()
        onSetUpConstraints()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    private func onConfigureView() {
        cityLabel.text = "Бишкек"
    }
    
    private func onAddSubViews() {
        addSubview(cityLabel)
    }
    
    private func onSetUpConstraints() {
        cityLabel.snp.makeConstraints {
            $0.left.right.equalTo(14)
            $0.top.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
}

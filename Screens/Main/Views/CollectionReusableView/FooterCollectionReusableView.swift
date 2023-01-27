import UIKit
import SnapKit

internal final class FooterCollectionReusableView: UICollectionReusableView {
    // MARK: Properties
    internal static let identifier = "FooterCollectionReusableView"
    private lazy var activityIndicator: MRActivityIndicator = .init()
    
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
    }
    
    private func onAddSubViews() {
        addSubview(activityIndicator)
    }
    
    private func onSetUpConstraints() {
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(40)
        }
    }
    
    // MARK: Internal methods
    internal func startAnimating() {
        activityIndicator.show()
    }
    
    internal func stopAnimating() {
        activityIndicator.hide()
    }
}

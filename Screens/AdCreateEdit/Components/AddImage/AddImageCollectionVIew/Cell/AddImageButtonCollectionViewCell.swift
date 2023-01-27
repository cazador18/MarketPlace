import UIKit.UICollectionViewCell
import SnapKit

internal final class AddImageButtonCollectionViewCell: UICollectionViewCell {
    
    internal static let identifier = "AddImageButtonCollectionViewCell"
    
    internal let addImageButton: UIButton = .init()
    
    internal var addImageButtonAction: (() -> Void)?
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        
        onAddSubviews()
        onSetUpConstraints()
        onConfigureCell()
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func onAddSubviews() {
        contentView.addSubview(addImageButton)
    }
    
    internal func onSetUpConstraints() {
        addImageButton.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }

    internal func onConfigureCell() {
        let squaredPlusImage = Asset.addImageBlock.image
        addImageButton.setImage(squaredPlusImage, for: .normal)
        addImageButton.addTarget(self, action: #selector(addImageButtonPressed), for: .touchUpInside)
        addImageButton.imageEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    }
    
    @objc private func addImageButtonPressed() {
        addImageButtonAction?()
    }
}

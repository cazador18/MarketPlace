import UIKit.UICollectionViewCell

internal final class ImageCollectionViewCell: UICollectionViewCell {
    
    internal static let identifier = "ImageCollectionViewCell"
    
    internal let addedImageImageView: UIImageView = .init()
    internal let trashButton: UIButton = .init()
    
    internal var didTapDeleteImage: ((Int) -> Void)?
    
    internal var indexItem: Int?
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        
        onConfigureCell()
        onAddSubviews()
        onSetUpConstraints()
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func onConfigureCell() {
        layer.borderWidth = 1
        layer.borderColor = Asset.borderColor.color.cgColor
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        trashButton.setImage(Asset.deleteIcon.image, for: .normal)
        trashButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        trashButton.layer.cornerRadius = 24 / 2
        trashButton.addTarget(self, action: #selector(removeImageButtonPressed), for: .touchUpInside)
    }
    
    internal func onAddSubviews() {
        contentView.addSubview(addedImageImageView)
        contentView.addSubview(trashButton)
    }
    
    internal func onSetUpConstraints() {
        addedImageImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
        
        trashButton.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(8)
            $0.trailing.equalTo(contentView.snp.trailing).inset(8)
            $0.width.height.equalTo(24)
        }
    }
    
    internal func setup(_ image: UIImage) {
        addedImageImageView.image = image
    }
                              
    @objc private func removeImageButtonPressed() {
        if let indexItem {
            didTapDeleteImage?(indexItem)
        }
    }
}

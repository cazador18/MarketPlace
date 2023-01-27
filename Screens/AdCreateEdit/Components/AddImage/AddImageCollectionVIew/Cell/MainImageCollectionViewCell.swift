import UIKit.UICollectionViewCell

internal final class MainImageCollectionViewCell: UICollectionViewCell {
    
    internal static let identifier = "MainImageCollectionViewCell"
    
    internal let addedImageImageView: UIImageView = .init()
    internal let trashButton: UIButton = .init()
    internal let mainPhotoLabel: UILabel = .init()
    internal let grayBackgroundView: UIView = .init()
    
    internal var isMainPhoto = true
    
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
        layer.borderColor = Asset.sellFasterButtonColor.color.cgColor
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        trashButton.setImage(Asset.deleteIcon.image, for: .normal)
        trashButton.layer.cornerRadius = 24 / 2
        trashButton.addTarget(self, action: #selector(removeImageButtonPressed), for: .touchUpInside)
        trashButton.tintColor = .white
        
        grayBackgroundView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        
        mainPhotoLabel.text = "Главное\nфото"
        mainPhotoLabel.numberOfLines = 0
        mainPhotoLabel.textAlignment = .center
        mainPhotoLabel.textColor = .white
        mainPhotoLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 13)
    }
    
    internal func onAddSubviews() {
        contentView.addSubview(addedImageImageView)
        contentView.addSubview(grayBackgroundView)
        grayBackgroundView.addSubview(trashButton)
        grayBackgroundView.addSubview(mainPhotoLabel)
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
        
        grayBackgroundView.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
        
        mainPhotoLabel.snp.makeConstraints {
            $0.center.equalTo(grayBackgroundView.snp.center)
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

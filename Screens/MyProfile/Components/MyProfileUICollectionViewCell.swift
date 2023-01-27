import UIKit
import Kingfisher

internal final class MyProfileUICollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    internal static let identifier = "myProfileUICollectionViewCell"
    
    private let viewsStatisticContentView: UIView = .init()
    private let eyeFillImage: UIImage? = .init(systemName: "eye.fill")
    private let eyeFillImageView: UIImageView = .init()
    private let viewCountLabel: UILabel = .init()
    private let stackViewContent: UIStackView = .init()
    private let numberFormatter = NumberFormatter()
    
    // MARK: - Lifecycle
    
    internal override func onConfigureCell() {
        super.onConfigureCell()
        
        eyeFillImageView.tintColor = .white
        eyeFillImageView.image = eyeFillImage
        
        viewCountLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 13)
        viewCountLabel.textColor = .white
        
        stackViewContent.distribution = .equalSpacing
        stackViewContent.axis = .horizontal
        stackViewContent.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        stackViewContent.spacing = UIStackView.spacingUseSystem
        stackViewContent.isLayoutMarginsRelativeArrangement = true
        stackViewContent.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 6)
        stackViewContent.layer.cornerRadius = 8
        
        oldPriceLabel.isHidden = true
        oMoneyImageView.isHidden = true
    }
    
    internal override func onAddSubviews() {
        super.onAddSubviews()
        
        addSubview(stackViewContent)
        stackViewContent.addArrangedSubview(eyeFillImageView)
        stackViewContent.addArrangedSubview(viewCountLabel)
    }
    
    internal override func onSetUpConstraints() {
        super.onSetUpConstraints()
        
        eyeFillImageView.snp.makeConstraints {
            $0.width.equalTo(eyeFillImageView.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        stackViewContent.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(16)
        }
        stackViewContent.setCustomSpacing(2, after: stackViewContent.subviews[0])
        stackViewContent.setCustomSpacing(4, after: stackViewContent.subviews[1])
    }
    
    private func emptyImageView() {
        adImageView.image = Asset.emptyImg.image
    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()
        emptyImageView()
        viewCountLabel.text = nil
        priceLabel.text = nil
        titleLabel.text = nil
        categoryNameLabel.text = nil
        locationLabel.text = nil
    }
    
    internal func configure(_ myAd: MyAds) {
        if let imageUrlString = myAd.minifyImages?.last,
           let imageUrl = URL(string: imageUrlString) {
            adImageView.kf.setImage(with: imageUrl)
        } else {
            adImageView.image = UIImage(asset: Asset.emptyImg)
        }
        
        if let viewCount = myAd.viewCount {
            if let number = NumberFormatter.withSeparator.string(from: viewCount as NSNumber) {
                viewCountLabel.text = number
            }
        }
        
        if let price = myAd.price,
           let priceNumber = numberFormatter.number(from: price),
           let separatedNumber = NumberFormatter.withSeparator.string(from: priceNumber) {
            priceLabel.text = separatedNumber
            if let currency = myAd.currency {
                if currency == "som" {
                    priceLabel.text? += " с"
                } else if currency == "usd" {
                    priceLabel.text? += " $"
                }
            }
        }
        
        if let title = myAd.title {
            titleLabel.text = title
        }
        
        if let category = myAd.category {
            categoryNameLabel.text = category.name
        }
        
        if let location = myAd.location {
            locationLabel.text = location.name
        }
    }
}

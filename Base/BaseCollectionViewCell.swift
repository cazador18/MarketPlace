import UIKit
import SnapKit

open class BaseCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Properties
    open lazy var adImageView: UIImageView = .init()
    open lazy var oMoneyImageView: UIImageView = .init()
    open lazy var priceLabel: UILabel = .init()
    open lazy var oldPriceLabel: UILabel = .init()
    open lazy var titleLabel: UILabel = .init()
    open lazy var categoryNameLabel: UILabel = .init()
    open lazy var locationLabel: UILabel = .init()
    open lazy var stackView: UIStackView = .init(arrangedSubviews: [priceLabel,
                                                                       oldPriceLabel,
                                                                       titleLabel,
                                                                       categoryNameLabel,
                                                                       locationLabel])
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        onConfigureCell()
        onAddSubviews()
        onSetUpConstraints()
        onSetUpTargets()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setConfigureAdImageView() {
        adImageView.layer.cornerRadius = 8
        adImageView.contentMode = .scaleAspectFill
        adImageView.clipsToBounds = true
    }
    
    private func setConfigureOMoneyImageView() {
        oMoneyImageView.image = Asset.oDengi.image
    }
    
    private func setConfigurePriceLabel() {
        priceLabel.font = UIFont(name: FontFamily.SFProText.semibold.name, size: 15)
        priceLabel.textColor = Asset.primaryTextColor.color
        priceLabel.textAlignment = .left
    }
    
    private func setConfigureOldPriceLabel() {
        oldPriceLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 12)
        oldPriceLabel.textColor = Asset.secondaryTextColor.color
        oldPriceLabel.textAlignment = .left
    }
    
    private func setConfigureTitleLabel() {
        titleLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 13)
        titleLabel.textColor = Asset.primaryTextColor.color
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
    }
    
    private func setConfigureCategoryNameLabel() {
        categoryNameLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 13)
        categoryNameLabel.textColor = Asset.secondaryTextColor.color
        categoryNameLabel.textAlignment = .left
    }
    
    private func setConfigureLocationLabel() {
        locationLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 13)
        locationLabel.textColor = Asset.secondaryTextColor.color
        locationLabel.textAlignment = .left
    }
    
    // MARK: - Open Methods
    open func onConfigureCell() {
        backgroundColor = .clear
        setConfigureAdImageView()
        setConfigurePriceLabel()
        setConfigureOldPriceLabel()
        setConfigureTitleLabel()
        setConfigureCategoryNameLabel()
        setConfigureLocationLabel()
        setConfigureOMoneyImageView()
    }
    open func onAddSubviews() {
        addSubview(adImageView)
        addSubview(oMoneyImageView)
        addSubview(stackView)
    }
    open func onSetUpConstraints() {
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 2
        
        adImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-112)
        }
        
        oMoneyImageView.snp.makeConstraints {
            $0.top.equalTo(adImageView.snp.bottom).offset(8)
            $0.right.equalToSuperview().inset(8)
            $0.width.height.equalTo(16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(oMoneyImageView.snp.top)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalTo(oMoneyImageView.snp.left).offset(-8)
        }
    }
    open func onSetUpTargets() {}
}

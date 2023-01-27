import UIKit
import SnapKit


internal final class EmptyView: UIView {
    internal lazy var emptyAdsImageView: UIImageView = .init()
    internal lazy var emptyAdsInfoLabel: UILabel = .init()
    
    internal convenience init() {
        self.init(frame: .zero)
        onConfigureView()
        onAddSubViews()
        onSetUpConstraints()
    }
    
    internal func onConfigureView() {
        emptyAdsImageView.image = Asset.emptyImg.image
        
        emptyAdsInfoLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 15)
        emptyAdsInfoLabel.textColor = Asset.secondaryTextColor.color
        emptyAdsInfoLabel.textAlignment = .center
        emptyAdsInfoLabel.text = "По данному запросу не нашлось ни одного объявления. Вы можете создать объявление и быть первым"
        emptyAdsInfoLabel.numberOfLines = 0

    }
    
    internal func onAddSubViews() {
        addSubview(emptyAdsImageView)
        addSubview(emptyAdsInfoLabel)
    }
    
    internal func onSetUpConstraints() {
        emptyAdsImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        emptyAdsInfoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalTo(emptyAdsImageView.snp.bottom).offset(16)
        }
    }
}

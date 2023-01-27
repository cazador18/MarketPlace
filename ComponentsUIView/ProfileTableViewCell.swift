import UIKit
import SnapKit

internal final class ProfileTableViewCell: BaseUITableViewCell {
    
    // MARK: - Properties
    internal static let identifier = "MyProfileTableViewCell"
    
    internal let userPhoneNumberLabel: UILabel = .init()
    internal let userCityLabel: UILabel = .init()
    internal let userAvatarImageView: UIImageView = .init()
    
    // MARK: - Lifecycle
    
    internal override func onConfigureCell() {
        userPhoneNumberLabel.text = "+996 700 000 104"
        userPhoneNumberLabel.textColor = Asset.primaryTextColor.color
        userPhoneNumberLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 17)
        
        userCityLabel.text = "г. Бишкек"
        userCityLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 15)
        userCityLabel.textColor = Asset.secondaryTextColor.color
        
        userAvatarImageView.contentMode = .scaleAspectFit
        userAvatarImageView.image = Asset.emptyAvatar.image
        userAvatarImageView.layer.cornerRadius = 20
        userAvatarImageView.clipsToBounds = true
    }
    
    internal override func onAddSubviews() {
        [userPhoneNumberLabel, userCityLabel, userAvatarImageView].forEach { contentView.addSubview($0) }
    }
    
    internal override func onSetUpConstraints() {
        userAvatarImageView.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(8)
            $0.top.equalTo(contentView.snp.top).offset(14)
            $0.bottom.equalTo(contentView.snp.bottom).inset(14)
            $0.height.equalTo(48)
            $0.width.equalTo(48)
        }

        userPhoneNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(userAvatarImageView.snp.trailing).offset(8)
            $0.top.equalTo(contentView.snp.top).offset(17)
        }

        userCityLabel.snp.makeConstraints {
            $0.leading.equalTo(userPhoneNumberLabel.snp.leading)
            $0.top.equalTo(userPhoneNumberLabel.snp.bottom).offset(4)
        }
    }
    
    internal func configure(phoneNumber: String) {
        userPhoneNumberLabel.text = phoneNumber
    }
}

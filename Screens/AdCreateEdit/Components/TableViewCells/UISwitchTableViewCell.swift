import UIKit

internal final class UISwitchTableViewCell: BaseUITableViewCell {
    internal let switchDescriptionLabel: UILabel = .init()
    internal let mainSwitch: UISwitch = .init()
    
    internal override func onConfigureCell() {
        switchDescriptionLabel.textColor = Asset.primaryTextColor.color
        switchDescriptionLabel.font = UIFont(font: FontFamily.SFProText.regular, size: 17)
    }
    
    internal override func onAddSubviews() {
        contentView.addSubview(switchDescriptionLabel)
        contentView.addSubview(mainSwitch)
    }
    
    internal override func onSetUpConstraints() {
        switchDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        mainSwitch.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).inset(16)
            $0.centerY.equalTo(switchDescriptionLabel.snp.centerY)
        }
    }
}

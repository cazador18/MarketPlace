import UIKit

internal final class SmallSpacingTableViewCell: BaseUITableViewCell {
    internal let mainLabel: UILabel = .init()
    
    internal override func onConfigureCell() {
        mainLabel.font = UIFont(font: FontFamily.SFProText.regular, size: 17)
    }
    
    internal override func onAddSubviews() {
        contentView.addSubview(mainLabel)
    }
    
    internal override func onSetUpConstraints() {
        mainLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(8)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
    }
}

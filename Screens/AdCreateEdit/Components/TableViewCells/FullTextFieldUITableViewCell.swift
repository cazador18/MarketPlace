import UIKit

internal final class FullTextFieldUITableViewCell: BaseUITableViewCell {
    
    internal let mainTextField: NewAdTextField = .init()
    
    override func onConfigureCell() {
        backgroundColor = Asset.secondaryButtonColor.color
    }
    
    override func onAddSubviews() {
        contentView.addSubview(mainTextField)
    }
    
    override func onSetUpConstraints() {
        mainTextField.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }
}

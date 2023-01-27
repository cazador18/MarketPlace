import UIKit.UITableViewCell

open class BaseUITableViewCell: UITableViewCell {
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        onAddSubviews()
        onSetUpConstraints()
        onConfigureCell()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func onConfigureCell() {
        selectionStyle = .none
    }
    
    open func onAddSubviews() {}
    
    open func onSetUpConstraints() {}
}

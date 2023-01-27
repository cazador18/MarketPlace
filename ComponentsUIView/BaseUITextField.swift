import SnapKit
import UIKit

open class BaseTextField: UITextField {
    
    open var textInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func customize() {
        backgroundColor = Asset.secondaryButtonColor.color
        tintColor = Asset.sellFasterButtonColor.color
        layer.cornerRadius = 8.0
        font = UIFont(font: FontFamily.SFProText.semibold, size: 17)
    }
    
}

extension BaseTextField {
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
}

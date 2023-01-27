import UIKit.UITextField

internal final class NewAdTextField: BaseTextField {
    
    internal override func customize() {
        backgroundColor = Asset.secondaryButtonColor.color
        tintColor = Asset.sellFasterButtonColor.color
        textColor = Asset.primaryTextColor.color
        font = UIFont(font: FontFamily.SFProText.semibold, size: 17)
    }
}

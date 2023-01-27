import UIKit

public class OTPInputField: UITextField {
    weak var previousTextField: OTPInputField?
    weak var nextTextField: OTPInputField?
    
    override public func deleteBackward() {
        text = ""
        previousTextField?.becomeFirstResponder()
    }
    
}

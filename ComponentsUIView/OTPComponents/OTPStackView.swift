import Foundation
import UIKit
import SnapKit


internal class OTPStackView: UIStackView {
    // MARK: - Private properties
    private let numberOfFields: Int8
    private var textFieldsCollection: [OTPInputField]
    private var warning: Bool
    private let fieldColor: UIColor
    private let warningFieldColor: UIColor
    private var remainingStrStack: [String] = []
    
    // MARK: - Initializers
    override internal init(frame: CGRect) {
        numberOfFields = 4
        textFieldsCollection = []
        warning = false
        fieldColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        warningFieldColor = UIColor(red: 1, green: 245/255, blue: 244/255, alpha: 1)
        super.init(frame: frame)
        setupStackView()
        addOTPFields()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Getters
    public func getOTP() -> String {
        var OTP: [Character] = .init(repeating: "\0", count: textFieldsCollection.count)
        
        for index in 0..<textFieldsCollection.count {
            if let character = textFieldsCollection[index].text {
                if textFieldsCollection[index].text != "" {
                    OTP[index] = Character(character)
                }
            }
        }
        let stringOTP = String(OTP)
        
        return stringOTP
    }
    
    // MARK: - Internal methods
    internal func cleanFields() {
        for textField in textFieldsCollection {
            textField.text = ""
        }
    }
    
    internal func setWarning(_ warning: Bool) {
        self.warning = warning
        if self.warning {
            setAllFieldColor(color: warningFieldColor)
        } else {
            setAllFieldColor(color: fieldColor)
        }
    }

    // MARK: - Private methods
    private func setupStackView() {
        backgroundColor = .clear
        isUserInteractionEnabled = true
        contentMode = .center
        distribution = .equalSpacing
        spacing = 16
    }
    
    private func addOTPFields() {
        for index in 0..<numberOfFields {
            let field = OTPInputField()
            setupTextField(field)
            textFieldsCollection.append(field)
            
            index != 0 ? (field.previousTextField = textFieldsCollection[Int(index)-1]) : (field.previousTextField = nil)
            
            index != 0 ? (textFieldsCollection[Int(index)-1].nextTextField = field) : ()
        }
        textFieldsCollection[0].becomeFirstResponder()
    }
    
    private func setupTextField(_ textField: OTPInputField) {
        textField.delegate = self
        addArrangedSubview(textField)
        textField.backgroundColor = fieldColor
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.font = UIFont(name: "SF Pro Text", size: 17)
        textField.font = .systemFont(ofSize: 17, weight: .semibold)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .yes
        textField.textContentType = .oneTimeCode
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(41)
        }
    }
    
    private func setAllFieldColor(color: UIColor) {
        for textField in textFieldsCollection {
            textField.backgroundColor = color
        }
    }
}

extension OTPStackView: UITextFieldDelegate {
    
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        if warning {
            setAllFieldColor(color: fieldColor)
            warning = false
        }
    }
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                            replacementString string: String) -> Bool {
        guard let textField = textField as? OTPInputField else { return true }
        if string.count > 1 {
            textField.resignFirstResponder()
            return false
        } else {
            if range.length == 0 {
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                } else {
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }
    
}

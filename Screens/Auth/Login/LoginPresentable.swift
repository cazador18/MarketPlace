import UIKit
import SnapKit

internal final class LoginPresentable: BaseView {
    
    // MARK: - Properties
    
    internal let userPhoneNumberTextField: BaseTextField = .init()
    internal let userPhoneNumberInfoLabel: UILabel = .init()
    internal let userPasswordTextField: BaseTextField = .init()
    internal let userCredentionalsInfoLabel: UILabel = .init()
    internal let userLoginButton: PrimaryButton = .init()
    internal let userRegisterButton: SecondaryButton = .init()
    internal let userActivityIndicator: MRActivityIndicator = .init()
    internal let userAgreementTextView: UITextView = .init()
    internal var userRegisterButtonAction: (() -> Void)?
    internal var userLoginButtonAction: ((String?, String?) -> Void)?
    internal var userPasswordTextFieldTextChangedAction: ((String?) -> Void)?
    
    // MARK: - Lifecycle
    
    internal override func onConfigureView() {
        backgroundColor = .white
        
        userPhoneNumberTextField.keyboardType = .numberPad
        userPhoneNumberTextField.font = .systemFont(ofSize: 17, weight: .semibold)
        userPhoneNumberTextField.text = "+996 "
        
        userPasswordTextField.keyboardType = .asciiCapable
        userPasswordTextField.font = .systemFont(ofSize: 17, weight: .semibold)
        userPasswordTextField.placeholder = "Введите пароль"
        userPasswordTextField.isSecureTextEntry = true
        
        userPhoneNumberInfoLabel.font = .systemFont(ofSize: 13, weight: .regular)
        userPhoneNumberInfoLabel.text = "Введите номер телефона"
        userPhoneNumberInfoLabel.numberOfLines = 0
        
        userLoginButton.setTitle("Войти", for: .normal)
        
        userRegisterButton.setTitle("Зарегестрироваться", for: .normal)

        userAgreementTextView.isUserInteractionEnabled = true
        userAgreementTextView.isEditable = false
        
        
        userAgreementTextView.tintColor = Asset.sellFasterButtonColor.color
        userAgreementTextView.attributedText = makeAttributedString()
        
        userCredentionalsInfoLabel.font = .systemFont(ofSize: 13, weight: .regular)
        userCredentionalsInfoLabel.text = "Неверный номер телефона или пароль"
        userCredentionalsInfoLabel.textColor = .red
    }
    
    internal override func onAddSubViews() {
        addSubview(userPhoneNumberTextField)
        addSubview(userPhoneNumberInfoLabel)
        addSubview(userPasswordTextField)
        addSubview(userLoginButton)
        addSubview(userRegisterButton)
        addSubview(userActivityIndicator)
        addSubview(userAgreementTextView)
        addSubview(userCredentionalsInfoLabel)
    }
    
    internal override func onSetUpConstraints() {
        userPhoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(40)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(48)
        }
        
        userPhoneNumberInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(userPhoneNumberTextField).offset(8)
            $0.trailing.equalTo(userPhoneNumberTextField)
            $0.top.equalTo(userPhoneNumberTextField.snp.bottom).offset(8)
        }
        
        userPasswordTextField.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(userPhoneNumberTextField)
            $0.height.equalTo(userPhoneNumberTextField)
            $0.top.equalTo(userPhoneNumberInfoLabel.snp.bottom).offset(24)
        }
        
        userLoginButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(userPhoneNumberTextField)
            $0.height.equalTo(userPhoneNumberTextField)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        userRegisterButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(userPhoneNumberTextField)
            $0.height.equalTo(userPhoneNumberTextField)
            $0.bottom.equalTo(userLoginButton.snp.top).offset(-16)
        }
        
        userActivityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        userAgreementTextView.snp.makeConstraints {
            $0.leading.equalTo(userLoginButton.snp.leading).offset(8)
            $0.trailing.equalTo(userLoginButton.snp.trailing).offset(-24)
            $0.bottom.equalTo(userRegisterButton.snp.top).offset(-8)
            $0.height.equalTo(48)
        }
        
        userCredentionalsInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(userPasswordTextField).offset(8)
            $0.trailing.equalTo(userPasswordTextField)
            $0.top.equalTo(userPasswordTextField.snp.bottom).offset(8)
        }
    }
    
    internal override func onSetUpTargets() {
        userPasswordTextField.addTarget(self, action: #selector(userPasswordTextFieldTextChanged), for: .editingChanged)
        
        userLoginButton.addTarget(self, action: #selector(userLoginButtonPressed), for: .touchUpInside)
        userRegisterButton.addTarget(self, action: #selector(userRegisterButtonPressed), for: .touchUpInside)
    }
   
    
    // MARK: View state
    
    @objc internal func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight = keyboardSize?.height ?? 0
        
        userLoginButton.snp.remakeConstraints {
            $0.directionalHorizontalEdges.equalTo(userPhoneNumberTextField)
            $0.height.equalTo(userPhoneNumberTextField)
            $0.bottom.equalTo(-(keyboardHeight + 16))
        }
        
        userActivityIndicator.snp.remakeConstraints {
            $0.height.width.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(-(keyboardHeight + 16))
        }
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.userLoginButton.superview?.layoutIfNeeded()
        })
    }
    
    @objc internal func keyboardWillHide(notification: Notification) {
        userLoginButton.snp.remakeConstraints {
            $0.directionalHorizontalEdges.equalTo(userPhoneNumberTextField)
            $0.height.equalTo(userPhoneNumberTextField)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        userActivityIndicator.snp.remakeConstraints {
            $0.height.width.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(-24)
        }
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.userLoginButton.superview?.layoutIfNeeded()
        }
    }
    
    internal func initialState() {
        userPasswordTextField.isHidden = true
        
        userLoginButton.isEnabled = false
        
        userActivityIndicator.isHidden = true
        
        userAgreementTextView.isHidden = true
        
        userCredentionalsInfoLabel.isHidden = true
    }
    
    internal func userLoginButtonPressedState() {
        userLoginButton.isHidden = true
        
        userRegisterButton.isHidden = true
        
        userAgreementTextView.isHidden = true
        
        userActivityIndicator.isHidden = false
        userActivityIndicator.show()
    }
    
    internal func invalidCredentialsState() {
        userLoginButton.isHidden = false
        
        userRegisterButton.isHidden = false
        
        userCredentionalsInfoLabel.isHidden = false
        
        userAgreementTextView.isHidden = true
        userActivityIndicator.isHidden = true
        userActivityIndicator.hide()
    }
}

// MARK: Selector actions

extension LoginPresentable {
    @objc private func userLoginButtonPressed() {
        userLoginButtonAction?(userPhoneNumberTextField.text, userPasswordTextField.text)
    }
    
    @objc private func userPasswordTextFieldTextChanged() {
        userPasswordTextFieldTextChangedAction?(userPasswordTextField.text)
    }
    @objc private func userRegisterButtonPressed() {
        userRegisterButtonAction?()
    }
}

// MARK: - Private helpers
extension LoginPresentable {
    private func makeAttributedString() -> NSAttributedString {
        let text = "Нажимая “Войти” вы принимаете\nусловия пользовательского соглашения"
        let range = (text as NSString).range(of: "условия пользовательского соглашения")
        let attributedString = NSMutableAttributedString(string: text)
        let url = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!
        attributedString.addAttribute(.link, value: url, range: range)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: 1), range: range)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.systemPink, range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemPink, range: range)
        return attributedString
    }
}

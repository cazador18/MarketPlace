import Foundation
import UIKit
import SnapKit

internal final class RegistrationPresentable: BaseView {
    
    private lazy var verticalStackView: UIStackView = .init()
    internal let numberTextField: BaseTextField = .init()
    private let numberLabel: UILabel = .init()
    private let firstStackView: UIStackView = .init()
    internal let passwordTextField: BaseTextField = .init()
    private let passwordLabel: UILabel = .init()
    private let secondStackView: UIStackView = .init()
    internal let repeatPasswordTextField: BaseTextField = .init()
    private let userPasswordInfoLabel: UILabel = .init()
    private let thirdStackView: UIStackView = .init()
    private let userAgreementTextView: UITextView = .init()
    internal let registrationButton: PrimaryButton = .init()
    
    internal override func onAddSubViews() {
        firstStackView.addArrangedSubviews(numberTextField, numberLabel)

        secondStackView.addArrangedSubviews(passwordTextField, passwordLabel)

        thirdStackView.addArrangedSubviews(repeatPasswordTextField, userPasswordInfoLabel)
        
        verticalStackView.addArrangedSubviews(
            firstStackView,
            secondStackView,
            thirdStackView
        )
        
        addSubview(verticalStackView)
        addSubview(userAgreementTextView)
        addSubview(registrationButton)
    }
    
    internal override func onConfigureView() {
        
        backgroundColor = .white
        
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 24
        verticalStackView.alignment = .fill
        
        numberTextField.keyboardType = .numberPad
        numberTextField.font = .systemFont(ofSize: 17, weight: .semibold)
        numberTextField.text = "+996 "
        
        numberLabel.text = "Введите номер телефона"
        numberLabel.font = UIFont(name: "Arial", size: 13)
        numberLabel.numberOfLines = 0
        numberLabel.textColor = .black
        
        firstStackView.axis = .vertical
        firstStackView.distribution = .fill
        firstStackView.spacing = 8
        firstStackView.alignment = .center
        
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.font = .systemFont(ofSize: 17, weight: .semibold)
        passwordTextField.placeholder = "Придумайте пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .oneTimeCode // hack to disable password suggestions

        passwordLabel.text = "Создайте пароль минимум из 8 символов, включая цифры, заглавные и строчные буквы"
        passwordLabel.font = UIFont(name: "Arial", size: 13)
        passwordLabel.numberOfLines = 0
        passwordLabel.textColor = .black
        
        secondStackView.axis = .vertical
        secondStackView.distribution = .fill
        secondStackView.spacing = 8
        secondStackView.alignment = .center
        
        repeatPasswordTextField.keyboardType = .asciiCapable
        repeatPasswordTextField.font = .systemFont(ofSize: 17, weight: .semibold)
        repeatPasswordTextField.placeholder = "Подтвердите пароль"
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.textContentType = .oneTimeCode
        
        userPasswordInfoLabel.font = .systemFont(ofSize: 13, weight: .regular)
        userPasswordInfoLabel.text = "Пароли не совпадают"
        userPasswordInfoLabel.textColor = .red
        
        thirdStackView.axis = .vertical
        thirdStackView.distribution = .fill
        thirdStackView.spacing = 8
        thirdStackView.alignment = .center
        
        
        userAgreementTextView.isUserInteractionEnabled = true
        userAgreementTextView.isEditable = false
        userAgreementTextView.tintColor = Asset.sellFasterButtonColor.color
        userAgreementTextView.attributedText = makeAttributedString()
        
        
        registrationButton.setTitle("Регистрация", for: .normal)
    }
    
    internal override func onSetUpTargets() {
    }
    
    internal override func onSetUpConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(24)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide) .inset(16)
        }
        
        firstStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }

        numberTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }

        numberLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
        }

        secondStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }

        passwordTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }

        passwordLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
        }

        thirdStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }

        repeatPasswordTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        userPasswordInfoLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        userAgreementTextView.snp.makeConstraints {
            $0.leading.equalTo(registrationButton.snp.leading).offset(8)
            $0.trailing.equalTo(registrationButton.snp.trailing).offset(-24)
            $0.bottom.equalTo(registrationButton.snp.top).offset(-8)
            $0.height.equalTo(48)
        }
        
        registrationButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(numberTextField)
            $0.height.equalTo(numberTextField)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
    }
    
    
    // MARK: View state
    
    @objc internal func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight = keyboardSize?.height ?? 0
        
        registrationButton.snp.remakeConstraints {
            $0.directionalHorizontalEdges.equalTo(numberTextField)
            $0.height.equalTo(numberTextField)
            $0.bottom.equalTo(-(keyboardHeight + 16))
        }
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.registrationButton.superview?.layoutIfNeeded()
        })
    }
    
    @objc internal func keyboardWillHide(notification: Notification) {
        registrationButton.snp.remakeConstraints {
            $0.directionalHorizontalEdges.equalTo(numberTextField)
            $0.height.equalTo(numberTextField)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.registrationButton.superview?.layoutIfNeeded()
        }
    }
    
    
    internal func initialState() {
        registrationButton.isEnabled = false
        
        userAgreementTextView.isHidden = true

        userPasswordInfoLabel.isHidden = true
    }
    
    internal func setRegistrationButtonEnabled(_ bool: Bool) {
        registrationButton.isEnabled = bool
    }
    
    internal func notSuitablePassword() {
        passwordTextField.backgroundColor = UIColor(red: 1, green: 245/255, blue: 244/255, alpha: 1)
        passwordLabel.textColor = .red
    }
    
    internal func notSamePasswords() {
        passwordTextField.backgroundColor = UIColor(red: 1, green: 245/255, blue: 244/255, alpha: 1)
        repeatPasswordTextField.backgroundColor = UIColor(red: 1, green: 245/255, blue: 244/255, alpha: 1)
        userPasswordInfoLabel.isHidden = false
    }
    
    internal func clearErrors() {
        passwordTextField.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        repeatPasswordTextField.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        passwordLabel.textColor = .black
        userPasswordInfoLabel.isHidden = true
    }
}

// MARK: - Private helpers
extension RegistrationPresentable {
    private func makeAttributedString() -> NSAttributedString {
        let text = "Нажимая “Регистрация” вы принимаете\nусловия пользовательского соглашения"
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

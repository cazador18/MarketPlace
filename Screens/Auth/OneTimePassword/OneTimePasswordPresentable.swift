import UIKit
import SnapKit

enum StateView {
    case error
    case normal
    case timeout
}

internal final class OneTimePasswordPresentable: BaseView {
    // MARK: - Private properties
    private lazy var oneTimePasswordStackView: OTPStackView = .init(frame: .zero)
    private lazy var infoLabel: UILabel = .init()
    private lazy var timerLabel: UILabel = .init()
    private lazy var errorLabel: UILabel = .init()
    private lazy var sendAgainButton: UIButton = {
        let button: UIButton = .init()
        button.setTitle("Отправить повторно", for: .normal)
        button.setTitleColor(Asset.blueTextColor.color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.isHidden = true
        return button
    }()
    private lazy var loginButton: PrimaryButton = .init()
    
    // MARK: - Internal properties
    internal var loginButtonAction: ((String) -> Void)?
    internal var sendAgainButtonAction: (() -> Void)?
    
    // MARK: - Private methods
    private func configureInfoLabel() {
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.font = .systemFont(ofSize: 15)
    }
    
    private func configureTimerLabel() {
        timerLabel.font = .systemFont(ofSize: 15)
        timerLabel.textColor = .lightGray
        timerLabel.text = "02:00"
    }
    
    private func configureErrorLabel() {
        errorLabel.text = "Неверный код"
        errorLabel.textColor = Asset.errorTextColor.color
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.isHidden = true
    }

    // MARK: - Internal methods
    internal override func onConfigureView() {
        backgroundColor = .white
        loginButton.setTitle("Войти", for: .normal)
        
        configureInfoLabel()
        configureTimerLabel()
        configureErrorLabel()
    }
    
    internal override func onAddSubViews() {
        addSubview(infoLabel)
        addSubview(oneTimePasswordStackView)
        addSubview(timerLabel)
        addSubview(loginButton)
        addSubview(sendAgainButton)
        addSubview(errorLabel)
    }

    internal override func onSetUpConstraints() {
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(96)
            $0.horizontalEdges.equalToSuperview().inset(32)
        }

        oneTimePasswordStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(oneTimePasswordStackView.snp.bottom).offset(16)
            $0.right.equalTo(oneTimePasswordStackView.snp.right)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        sendAgainButton.snp.makeConstraints {
            $0.height.equalTo(19)
            $0.top.equalTo(oneTimePasswordStackView.snp.bottom).offset(16)
            $0.right.equalTo(oneTimePasswordStackView.snp.right)
        }
        
        errorLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(sendAgainButton.snp.top)
            $0.left.equalTo(oneTimePasswordStackView.snp.left).offset(4)
        }
    }
    
    internal override func onSetUpTargets() {
        loginButton.addTarget(self,
                              action: #selector(handleLoginButtonTap),
                              for: .touchUpInside)
        sendAgainButton.addTarget(self,
                                  action: #selector(handleSendAgainButtonTap),
                                  for: .touchUpInside)
    }
    
    internal func setPhoneNumber(phoneNumber: String) {
        infoLabel.text = "SMS c кодом отправлено на номер\n\(phoneNumber)"
    }
    
    internal func updateTime(text: String) {
        timerLabel.text = text
    }
    
    @objc internal func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight = keyboardSize?.height ?? 0
        
        loginButton.snp.remakeConstraints {
            $0.height.equalTo(48)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(-(keyboardHeight + 16))
        }
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.loginButton.superview?.layoutIfNeeded()
        })
    }
    
    @objc internal func keyboardWillHide(notification: Notification) {
        loginButton.snp.remakeConstraints {
            $0.height.equalTo(48)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.loginButton.superview?.layoutIfNeeded()
        }
    }
    
    internal func updateView(state: StateView) {
        switch state {
        case .error:
            sendAgainButton.isHidden = false
            timerLabel.isHidden = true
            errorLabel.isHidden = false
            loginButton.isEnabled = false
            oneTimePasswordStackView.setWarning(true)
        case .normal:
            sendAgainButton.isHidden = true
            timerLabel.isHidden = false
            errorLabel.isHidden = true
            loginButton.isEnabled = true
            oneTimePasswordStackView.setWarning(false)
            oneTimePasswordStackView.cleanFields()
        case .timeout:
            sendAgainButton.isHidden = false
            timerLabel.isHidden = true
            loginButton.isEnabled = false
            oneTimePasswordStackView.setWarning(false)
        }
    }
}

extension OneTimePasswordPresentable {
    @objc private func handleLoginButtonTap() {
        loginButtonAction?(oneTimePasswordStackView.getOTP())
    }
    
    @objc private func handleSendAgainButtonTap() {
        sendAgainButtonAction?()
    }
}

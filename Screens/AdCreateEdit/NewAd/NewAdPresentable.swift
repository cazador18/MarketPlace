import UIKit
import SnapKit

internal final class NewAdPresentable: AdReusableView {
    internal let userAgreementTextView: UITextView = .init()
    internal let submitAdButton: PrimaryButton = .init()
    internal let containerView: UIView = .init()
    internal let activityIndicator: MRActivityIndicator = .init()
    internal let footerTableViewStackView: UIStackView = .init()
    
    // MARK: - Actions
    internal var titleTextFieldValueChangedAction: ((String?) -> Void)?
    internal var descriptionTextFieldValueChangedAction: ((String?) -> Void)?
    internal var submitAdButtonAction: ((NewAdBodyModel) -> Void)?
    
    internal override func onConfigureView() {
        super.onConfigureView()
        
        submitAdButton.setTitle("Подать объявление", for: .normal)
        submitAdButton.isEnabled = false

        userAgreementTextView.isUserInteractionEnabled = true
        userAgreementTextView.isEditable = false
        userAgreementTextView.tintColor = Asset.sellFasterButtonColor.color
        userAgreementTextView.attributedText = makeAttributedString()
        userAgreementTextView.textColor = Asset.secondaryTextColor.color
        userAgreementTextView.backgroundColor = .clear
        
        footerTableViewStackView.axis = .vertical
        footerTableViewStackView.spacing = 8
        footerTableViewStackView.addArrangedSubview(userAgreementTextView)
        footerTableViewStackView.addArrangedSubview(submitAdButton)
        
        activityIndicator.isHidden = true
        
        containerView.frame = CGRect(x: 0, y: 0, width: 0, height: 140)
    }
    
    internal override func onSetUpTargets() {
        super.onSetUpTargets()
        
        titleCell.mainTextField.addTarget(self, action: #selector(titleTextFieldValueChanged), for: .editingChanged)
        
        descriptionCell.mainTextField.addTarget(self, action: #selector(descriptionTextFieldValueChanged), for: .editingChanged)
        
        submitAdButton.addTarget(self, action: #selector(didPressSubmitAdButton), for: .touchUpInside)
    }
    
    internal override func onAddSubViews() {
        super.onAddSubViews()

        newAdTableView.tableFooterView = containerView
        containerView.addSubview(footerTableViewStackView)
        containerView.addSubview(activityIndicator)
    }
    
    internal override func onSetUpConstraints() {
        super.onSetUpConstraints()

        footerTableViewStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8).priority(999)
            make.top.equalToSuperview().inset(40)
        }

        userAgreementTextView.snp.makeConstraints { make in
            make.height.equalTo(36)
        }

        submitAdButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
    }
    
    // MARK: - Private methods
    
    internal func newAdButtonPressedState() {
        userAgreementTextView.isHidden = true
        submitAdButton.isHidden = true
        
        activityIndicator.isHidden = false
        activityIndicator.show()
    }
    
    @objc private func titleTextFieldValueChanged(_ titleTextField: UITextField) {
        titleTextFieldValueChangedAction?(titleTextField.text)
    }
    
    @objc private func descriptionTextFieldValueChanged(_ descriptionTextField: UITextField) {
        descriptionTextFieldValueChangedAction?(descriptionTextField.text)
    }
    
    @objc private func didPressSubmitAdButton() {
        let title = titleCell.mainTextField.text ?? ""
        let description = descriptionCell.mainTextField.text ?? ""
        
        var model = NewAdBodyModel(title: title, description: description)
        model.contractPrice = contractPriceCell.mainSwitch.isOn
        model.price = priceCell.mainTextField.text
        model.oMoneyPay = oMoneyCell.mainSwitch.isOn
        model.isWhatsAppEnabled = writeToWhatsAppCell.mainSwitch.isOn
        model.whatsAppPhoneNumber = whatsAppPhoneNumberCell.mainTextField.text
        model.isTelegramEnabled = writeToTelegramCell.mainSwitch.isOn
        model.telegramUsername = telegramUsernameCell.mainTextField.text
        
        submitAdButtonAction?(model)
    }
}

// MARK: - Helpers

extension NewAdPresentable {
    private func makeAttributedString() -> NSAttributedString {
        let text = "Нажимая “Подать объявление” вы принимаете\nусловия пользовательского соглашения"
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

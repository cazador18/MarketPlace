import UIKit

internal final class EditAdPresentable: AdReusableView {
    
    internal let deleteAdButton: UIButton = .init()
    internal let activateAdButton: PrimaryButton = .init()
    internal let containerView: UIView = .init()
    internal let activityIndicator: MRActivityIndicator = .init()
    internal let footerTableViewStackView: UIStackView = .init()
    
    // MARK: - Actions
    
    internal var didChangeTitleAction: ((String?) -> Void)?
    internal var didChangeDescriptionAction: ((String?) -> Void)?
    internal var didChangeContractPriceAction: ((Bool?) -> Void)?
    internal var didChangePriceAction: ((String?) -> Void)?
    internal var didChangeOMoneyPayAction: ((Bool?) -> Void)?
    internal var didChangeWriteToWhatsAppAction: ((Bool) -> Void)?
    internal var didChangeWriteToTelegramAction: ((Bool) -> Void)?
    
    internal var deleteAdButtonAction: (() -> Void)?
    internal var activateAdButtonAction: (() -> Void)?
    
    private var myAdModel: MyAds?
    
    internal override func onConfigureView() {
        super.onConfigureView()
        deleteAdButton.setTitle("Удалить объявление", for: .normal)
        deleteAdButton.titleLabel?.font = UIFont(name: FontFamily.SFProDisplay.medium.name, size: 17)
        deleteAdButton.setTitleColor(Asset.redButtonColor.color, for: .normal)
        
        footerTableViewStackView.axis = .vertical
        footerTableViewStackView.spacing = 8
        footerTableViewStackView.addArrangedSubview(deleteAdButton)
        footerTableViewStackView.addArrangedSubview(activateAdButton)
        
        activateAdButton.setTitle("Активировать объявление", for: .normal)
        activateAdButton.titleLabel?.font = UIFont(name: FontFamily.SFProDisplay.medium.name, size: 17)
        
        containerView.frame = CGRect(x: 0, y: 0, width: 0, height: 128)
        
        activityIndicator.isHidden = true
    }
    
    internal override func onAddSubViews() {
        super.onAddSubViews()
        
        newAdTableView.tableFooterView = containerView
        
        containerView.addSubview(footerTableViewStackView)
        containerView.addSubview(activityIndicator)
    }
    
    internal override func onSetUpConstraints() {
        super.onSetUpConstraints()
        
        footerTableViewStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8).priority(999)
            $0.top.equalToSuperview().inset(20)
        }
        
        activateAdButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        deleteAdButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
    }
    
    internal override func onSetUpTargets() {
        super.onSetUpTargets()
        titleCell.mainTextField.addTarget(self, action: #selector(didChangeTitle), for: .editingChanged)
        
        descriptionCell.mainTextField.addTarget(self, action: #selector(didChangeDescription), for: .editingChanged)
        
        contractPriceCell.mainSwitch.addTarget(self, action: #selector(didChangeContractPrice), for: .valueChanged)
        
        priceCell.mainTextField.addTarget(self, action: #selector(didChangePrice), for: .editingChanged)
        
        oMoneyCell.mainSwitch.addTarget(self, action: #selector(didChangeOMoneyPay), for: .valueChanged)
        
        writeToWhatsAppCell.mainSwitch.addTarget(self, action: #selector(didChangeWriteToWhatsApp), for: .valueChanged)
        
        
        writeToTelegramCell.mainSwitch.addTarget(self, action: #selector(didChangeWriteToTelegram), for: .valueChanged)
        
        deleteAdButton.addTarget(self, action: #selector(didPressDeleteAdButton), for: .touchUpInside)
        activateAdButton.addTarget(self, action: #selector(didPressActivateAdButton), for: .touchUpInside)
    }
    
    internal func setMyAdModel(with model: MyAds) {
           myAdModel = model
    }
    
    internal func setupUI(with adType: MyAds) {
        titleCell.mainTextField.text = adType.title
        categoryCell.mainTextField.text = adType.category?.name
        descriptionCell.mainTextField.text = adType.description
        
        if let dealType = adType.adType {
            if dealType == "Купить" {
                dealTypeCell.mainTextField.text = "Купить"
            } else if dealType == "Продать" {
                dealTypeCell.mainTextField.text = "Продать"
            }
        }
        
        contractPriceCell.mainSwitch.isOn = adType.contractPrice ?? false
        
        if let currency = adType.currency {
            if currency == "som" {
                currencyCell.mainTextField.text = "Сомы"
            } else if currency == "usd" {
                currencyCell.mainTextField.text = "Доллары"
            }
        }
        
        priceCell.mainTextField.text = adType.price
        oMoneyCell.mainSwitch.isOn = adType.oMoneyPay ?? false
        
        if let whatsAppNumber = adType.whatsapp {
            writeToWhatsAppCell.mainSwitch.isOn = true
            whatsAppPhoneNumberCell.mainTextField.text = whatsAppNumber
        }
        
        if let telegramUsername = adType.telegram {
            writeToTelegramCell.mainSwitch.isOn = true
            telegramUsernameCell.mainTextField.text = telegramUsername
        }
    }
    
    internal func buttonPressedState() {
        deleteAdButton.isHidden = true
        activateAdButton.isHidden = true
        
        activityIndicator.isHidden = false
        activityIndicator.show()
    }
    
    internal func disableButtonPressedState() {
        deleteAdButton.isHidden = false
        activateAdButton.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.hide()
    }
    
    // MARK: - Private methods
    
    @objc private func didChangeTitle(_ titleTextField: UITextField) {
        didChangeTitleAction?(titleTextField.text)
    }
    
    @objc private func didChangeDescription(_ descriptionTextField: UITextField) {
        didChangeDescriptionAction?(descriptionTextField.text)
    }
    
    @objc private func didChangeContractPrice() {
        didChangeContractPriceAction?(contractPriceCell.mainSwitch.isOn)
    }
    
    @objc private func didChangePrice(_ priceTextField: UITextField) {
        didChangePriceAction?(priceTextField.text)
    }
    
    @objc private func didChangeOMoneyPay() {
        didChangeOMoneyPayAction?(oMoneyCell.mainSwitch.isOn)
    }
    
    @objc private func didChangeWriteToWhatsApp() {
        didChangeWriteToWhatsAppAction?(writeToWhatsAppCell.mainSwitch.isOn)
    }
    
    @objc private func didChangeWriteToTelegram() {
        didChangeWriteToTelegramAction?(writeToTelegramCell.mainSwitch.isOn)
    }
    
    @objc private func didPressDeleteAdButton() {
        deleteAdButtonAction?()
    }
    
    @objc private func didPressActivateAdButton() {
        activateAdButtonAction?()
    }
}

import UIKit

internal class AdReusableView: BaseView {
    
    // MARK: - Properties
    
    internal let newAdTableView: UITableView = .init()
    internal let titleCell: FullTextFieldUITableViewCell = .init()
    internal let categoryCell: FullTextFieldUITableViewCell = .init()
    internal let descriptionCell: FullTextFieldUITableViewCell = .init()
    internal let dealTypeCell: FullTextFieldUITableViewCell = .init()
    internal let contractPriceCell: UISwitchTableViewCell = .init()
    internal let currencyCell: FullTextFieldUITableViewCell = .init()
    internal let priceCell: FullTextFieldUITableViewCell = .init()
    internal let locationCell: FullTextFieldUITableViewCell = .init()
    internal let oMoneyCell: UISwitchTableViewCell = .init()
    internal let writeToWhatsAppCell: UISwitchTableViewCell = .init()
    internal let writeToTelegramCell: UISwitchTableViewCell = .init()
    internal let addImagesCell: AddImageTableViewCell = .init()
    internal let whatsAppPhoneNumberCell: FullTextFieldUITableViewCell = .init()
    internal let telegramUsernameCell: FullTextFieldUITableViewCell = .init()
    
    internal lazy var sectionsArray: [UITableViewCell] = [
        titleCell,
        categoryCell,
        descriptionCell,
        dealTypeCell,
        contractPriceCell,
        currencyCell,
        priceCell,
        locationCell,
        oMoneyCell,
        writeToWhatsAppCell,
        writeToTelegramCell,
        addImagesCell
    ]
    
    internal var addImageAction: (() -> Void)?
    internal var dealTypeAction: (() -> Void)?
    internal var currencyTypeAction: (() -> Void)?
    internal var categoryTypeAction: (() -> Void)?
    
    private var dataSource: AddImageCollectionViewDataSource?
    
    // MARK: - Life cycle
    
    internal override func onConfigureView() {
        backgroundColor = .white
        
        newAdTableView.delegate = self
        newAdTableView.dataSource = self
        
        newAdTableView.separatorStyle = .none
        newAdTableView.sectionFooterHeight = 8
        newAdTableView.tableHeaderView = UIView(frame: CGRect(x: .zero, y: .zero, width: .zero, height: CGFloat.leastNonzeroMagnitude))
        
        titleCell.mainTextField.placeholder = "Название"
        
        categoryCell.mainTextField.isEnabled = false
        categoryCell.mainTextField.backgroundColor = nil
        categoryCell.accessoryType = .disclosureIndicator
        categoryCell.mainTextField.placeholder = "Категория"
        
        descriptionCell.mainTextField.placeholder = "Описание"
        
        dealTypeCell.mainTextField.placeholder = "Тип сделки"
        dealTypeCell.mainTextField.isEnabled = false
        dealTypeCell.mainTextField.backgroundColor = nil
        dealTypeCell.accessoryType = .disclosureIndicator
        
        priceCell.mainTextField.keyboardType = .decimalPad
        
        contractPriceCell.switchDescriptionLabel.text = "Цена договорная"
        
        currencyCell.mainTextField.isEnabled = false
        currencyCell.mainTextField.backgroundColor = nil
        currencyCell.accessoryType = .disclosureIndicator
        currencyCell.mainTextField.placeholder = "Валюта"
        
        priceCell.mainTextField.placeholder = "Цена"
        
        locationCell.mainTextField.text = "г. Бишкек"
        locationCell.mainTextField.isEnabled = false
        
        oMoneyCell.switchDescriptionLabel.text = "Оплата через О!Деньги"
        
        writeToWhatsAppCell.switchDescriptionLabel.text = "Писать мне в WhatsApp"
        
        writeToTelegramCell.switchDescriptionLabel.text = "Писать мне в Telegram"
        
        whatsAppPhoneNumberCell.mainTextField.keyboardType = .numberPad
        
        whatsAppPhoneNumberCell.mainTextField.text = "+996 "
        whatsAppPhoneNumberCell.mainTextField.clearButtonMode = .whileEditing
        whatsAppPhoneNumberCell.mainTextField.tag = 0
        
        telegramUsernameCell.mainTextField.text = "@ "
        telegramUsernameCell.mainTextField.clearButtonMode = .whileEditing
        telegramUsernameCell.mainTextField.tag = 1
    }
    
    internal override func onSetUpTargets() {
        contractPriceCell.mainSwitch.addTarget(self, action: #selector(didToggleCotractPriceCellSwitch), for: .valueChanged)
        
        writeToWhatsAppCell.mainSwitch.addTarget(self, action: #selector(didToggleWriteToWhatsappCellSwitch), for: .valueChanged)
        
        writeToTelegramCell.mainSwitch.addTarget(self, action: #selector(didToggleWriteToTelegramCellSwitch), for: .valueChanged)
    }
    
    internal override func onAddSubViews() {
        addSubview(newAdTableView)
    }
    
    internal override func onSetUpConstraints() {
        newAdTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
    
    internal func setupImagesDataSource(_ dataSource: AddImageCollectionViewDataSource) {
        addImagesCell.addImageCollectionView.dataSource = dataSource
        self.dataSource = dataSource
    }
    
    // MARK: Private methods
    
    @objc private func didToggleCotractPriceCellSwitch() {
        if contractPriceCell.mainSwitch.isOn {
            sectionsArray.remove(at: 5)
            sectionsArray.remove(at: 5)
        } else {
            sectionsArray.insert(priceCell, at: 5)
            sectionsArray.insert(currencyCell, at: 5)
        }
        
        newAdTableView.reloadData()
    }
    
    @objc private func didToggleWriteToWhatsappCellSwitch() {
        if contractPriceCell.mainSwitch.isOn {
            if writeToWhatsAppCell.mainSwitch.isOn {
                sectionsArray.insert(whatsAppPhoneNumberCell, at: 8)
            } else {
                sectionsArray.remove(at: 8)
            }
        } else {
            if writeToWhatsAppCell.mainSwitch.isOn {
                sectionsArray.insert(whatsAppPhoneNumberCell, at: 10)
            } else {
                sectionsArray.remove(at: 10)
            }
        }

        newAdTableView.reloadData()
    }
    
    @objc private func didToggleWriteToTelegramCellSwitch() {
        if contractPriceCell.mainSwitch.isOn {
            if writeToWhatsAppCell.mainSwitch.isOn {
                if writeToTelegramCell.mainSwitch.isOn {
                    sectionsArray.insert(telegramUsernameCell, at: 10)
                } else {
                    sectionsArray.remove(at: 10)
                }
            } else {
                if writeToTelegramCell.mainSwitch.isOn {
                    sectionsArray.insert(telegramUsernameCell, at: 9)
                } else {
                    sectionsArray.remove(at: 9)
                }
            }
        } else {
            if writeToWhatsAppCell.mainSwitch.isOn {
                if writeToTelegramCell.mainSwitch.isOn {
                    sectionsArray.insert(telegramUsernameCell, at: 12)
                } else {
                    sectionsArray.remove(at: 12)
                }
            } else {
                if writeToTelegramCell.mainSwitch.isOn {
                    sectionsArray.insert(telegramUsernameCell, at: 11)
                } else {
                    sectionsArray.remove(at: 11)
                }
            }
        }
        
        newAdTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension AdReusableView: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sectionsArray[indexPath.section] === addImagesCell {
            return 100
        }
        
        return 48
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            categoryTypeAction?()
        case 3:
            dealTypeAction?()
        case 5:
            if !contractPriceCell.mainSwitch.isOn {
                currencyTypeAction?()
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension AdReusableView: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsArray.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sectionsArray[indexPath.section]
        switch indexPath.section {
        case 9:
            dataSource?.handleAddImageButtonAction = addImageAction
            dataSource?.reloadData = addImagesCell.addImageCollectionView.reloadData
        default:
            return cell
        }
        
        return cell
    }
}

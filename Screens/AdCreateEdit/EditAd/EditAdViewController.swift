import UIKit

internal class EditAdViewController: VMController<EditAdPresentable, EditAdViewModelInput> {
    internal override func onConfigureController() {
        title = "Редактировать объявление"
    }
    
    internal override func onConfigureViewModel() {
        viewModel.output = self
        viewModel.loadImagesInAd()
    }
    
    internal override func onConfigureActions() {
        if let adModel = viewModel.adModel {
            rootView.setupUI(with: adModel)
        }
        
        rootView.categoryTypeAction = viewModel.chooseCategoryTypeButtonTap
        rootView.dealTypeAction = viewModel.chooseDealTypeButtonTap
        rootView.currencyTypeAction = viewModel.chooseCurrencyTypeButtonTap
        rootView.addImageAction = viewModel.addImageButtonTap
        rootView.setupImagesDataSource(viewModel.addImageDataSource)
        
        // MARK: - Button actions
        
        rootView.deleteAdButtonAction = viewModel.viewDeleteAdButtonTap
        rootView.activateAdButtonAction = viewModel.activateAdButtonTap
        
        // MARK: - textField value changed actions
        rootView.whatsAppPhoneNumberCell.mainTextField.delegate = viewModel
        rootView.telegramUsernameCell.mainTextField.delegate = viewModel
        
        rootView.didChangeTitleAction = viewModel.titleTextFieldValueChanged(_:)
        rootView.didChangeDescriptionAction = viewModel.descriptionTextFieldValueChanged(_:)
        rootView.didChangeContractPriceAction = viewModel.contractPriceSwitchValueChanged(_:)
        rootView.didChangePriceAction = viewModel.priceTextFieldValueChanged(_:)
        rootView.didChangeOMoneyPayAction = viewModel.oMoneySwitchValueChanged(_:)
        rootView.didChangeWriteToWhatsAppAction = viewModel.writeToWhatsAppSwitchValueChanged(_:)
        rootView.didChangeWriteToTelegramAction = viewModel.writeToTelegramSwitchValueChanged(_:)
    }
}

// MARK: NewAdViewModelOutput

extension EditAdViewController: EditAdViewModelOutput {
    internal func categorySelected(_ category: Category?) {
        rootView.categoryCell.mainTextField.text = category?.name
    }
    
    internal func dealSelected(_ deal: String?) {
        rootView.dealTypeCell.mainTextField.text = deal
    }
    
    internal func currencySelected(_ currency: String?) {
        rootView.currencyCell.mainTextField.text = currency
    }
    
    internal func isActivateAdButtonEnabled(_ flag: Bool) {
        rootView.activateAdButton.isEnabled = flag
    }
    
    internal func showAlert(message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.viewModel.alertDeleteAdButtonTap()
        }))
        self.present(alertController, animated: true)
    }
    
    internal func showSingleButtonAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: .default, handler: { [weak self] _ in
            self?.viewModel.alertOkButtonTap()
        }))
        self.present(alertController, animated: true)
    }
    
    internal func buttonPressedState() {
        rootView.buttonPressedState()
    }
    
    internal func disableButtonPressedState() {
        rootView.disableButtonPressedState()
    }
}

import Foundation
import UIKit

internal final class NewAdController: VMController<NewAdPresentable, NewAdViewModelInput> {
    // MARK: - Lifecycle
    
    internal override func onConfigureController() {
        title = "Подать объявление"
        rootView.setupImagesDataSource(viewModel.addImageDataSource)
    }
    
    internal override func onConfigureActions() {
        
        // MARK: - Button actions
        rootView.addImageAction = viewModel.addImageButtonTap
        rootView.categoryTypeAction = viewModel.chooseCategoryTypeButtonTap
        rootView.dealTypeAction = viewModel.chooseDealTypeButtonTap
        rootView.currencyTypeAction = viewModel.chooseCurrencyTypeButtonTap
        rootView.submitAdButtonAction = viewModel.submitAddButtonTap
        
        // MARK: - textField value changed actions
        
        rootView.titleTextFieldValueChangedAction = viewModel.titleTextFieldValueChanged(_:)
        rootView.descriptionTextFieldValueChangedAction = viewModel.descriptionTextFieldValueChanged(_:)
        
        rootView.whatsAppPhoneNumberCell.mainTextField.delegate = viewModel
        rootView.telegramUsernameCell.mainTextField.delegate = viewModel
    }
    
    internal override func onConfigureViewModel() {
        viewModel.output = self
    }
}

// MARK: NewAdViewModelOutput

extension NewAdController: NewAdViewModelOutput {
    internal func isSubmitButtonEnabled(_ flag: Bool) {
        rootView.submitAdButton.isEnabled = flag
    }
    
    internal func categorySelected(_ category: Category?) {
        rootView.categoryCell.mainTextField.text = category?.name
    }
    
    internal func dealSelected(_ deal: String?) {
        rootView.dealTypeCell.mainTextField.text = deal
    }
    
    internal func currencySelected(_ currency: String?) {
        rootView.currencyCell.mainTextField.text = currency
    }
    
    internal func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
    
    internal func showDismissAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.viewModel.alertOkButtonTap()
        }))
        self.present(alertController, animated: true)
    }
    
    internal func newAdButtonPressedState() {
        rootView.newAdButtonPressedState()
    }
}

import Foundation
import UIKit

internal final class OneTimePasswordController:
    VMController <OneTimePasswordPresentable, OneTimePasswordViewModelInput> {
    // MARK: - Internal methods
    internal override func onConfigureController() {
        title = "Регистрация"
    }
    
    internal override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    internal override func onConfigureActions() {
        viewModel.runTimer()
        rootView.loginButtonAction = viewModel.loginButtonTap
        rootView.sendAgainButtonAction = viewModel.sendAgainButtonTap
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(rootView, selector: #selector(rootView.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(rootView, selector: #selector(rootView.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    internal override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(rootView, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(rootView, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    internal func setPhoneNumber(phoneNumber: String) {
        rootView.setPhoneNumber(phoneNumber: phoneNumber)
        viewModel.setPhoneNumber(phoneNumber: phoneNumber)
    }
}

// MARK: - OneTimePasswordViewModelOutput
extension OneTimePasswordController: OneTimePasswordViewModelOutput {
    internal func setOutputButton(state: StateView) {
        rootView.updateView(state: state)
    }
    
    internal func setOutputText(_ text: String) {
        rootView.updateTime(text: text)
    }
}

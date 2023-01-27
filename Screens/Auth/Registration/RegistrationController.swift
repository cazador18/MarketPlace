import UIKit

internal final class RegistrationController:
    VMController <RegistrationPresentable, RegistrationViewModelInput> {

    internal override func onConfigureActions() {
        rootView.numberTextField.delegate = self
        rootView.passwordTextField.delegate = self
        rootView.repeatPasswordTextField.delegate = self
        rootView.registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
    }

    @objc func registrationButtonTapped() {
        viewModel.userRegisterButtonTap()
    }

    internal override func onConfigureViewModel() {
        viewModel.output = self
    }
    internal override func onConfigureController() {
        self.navigationItem.title = "Регистрация"
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.initialState()
        
        NotificationCenter.default.addObserver(rootView, selector: #selector(rootView.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(rootView, selector: #selector(rootView.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    internal override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(rootView, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(rootView, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension RegistrationController: RegistrationViewModelOutput {
    func updatePhoneNumber(_ phoneNumber: String?) {
        rootView.numberTextField.text = phoneNumber
    }

    func updatePassword(_ password: String?) {
        rootView.passwordTextField.text = password
    }

    func updateRepeatPassword(_ repeatedPassword: String?) {
        rootView.repeatPasswordTextField.text = repeatedPassword
    }


    internal func clearErrors() {
        rootView.clearErrors()
    }
    
    internal func setRegistrationButtonEnabled(_ bool: Bool) {
        rootView.setRegistrationButtonEnabled(bool)
    }
    
    internal func notSuitablePassword() {
        rootView.notSuitablePassword()
    }
    
    internal func notSamePasswords() {
        rootView.notSamePasswords()
    }
    
    internal func setRegistationButtonEnbaled(_ bool: Bool) {
        rootView.numberTextField.isEnabled = bool
    }

    internal func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true)
    }
}

extension RegistrationController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if textField == rootView.numberTextField {
            viewModel.phoneNumberInputChanged(newString)
        } else if textField == rootView.passwordTextField {
            viewModel.passwordInputChanged(newString)
        } else if textField == rootView.repeatPasswordTextField {
            viewModel.repeatedPasswordInputChanged(newString)
        }
        return false
    }
}

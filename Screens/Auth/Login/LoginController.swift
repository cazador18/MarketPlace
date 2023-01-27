import UIKit

internal final class LoginController: VMController <LoginPresentable, LoginViewModelInput> {
    
    // MARK: - Lifecycle
    
    internal override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    internal override func onConfigureController() {
        self.navigationItem.title = "Войти"
    }
    
    internal override func onConfigureActions() {
        rootView.userLoginButtonAction = viewModel.userLoginButtonTap
        rootView.userRegisterButtonAction = viewModel.userRegisterButtonTap
        rootView.userPhoneNumberTextField.delegate = viewModel
        rootView.userPasswordTextFieldTextChangedAction = viewModel.userPassowrdTextFieldTextChanged
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.initialState()
        
        NotificationCenter.default.addObserver(rootView, selector: #selector(rootView.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(rootView, selector: #selector(rootView.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    internal override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        rootView.userPhoneNumberTextField.text = "+996 "
        rootView.userPasswordTextField.text = ""
        
        NotificationCenter.default.removeObserver(rootView, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(rootView, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - LoginViewModelOutput

extension LoginController: LoginViewModelOutput {
    internal func loginButtonPressedState() {
        rootView.userLoginButtonPressedState()
    }
    
    internal func isValidCredentials(_ flag: Bool) {
        if flag {
            rootView.userActivityIndicator.hide()
        } else {
            rootView.invalidCredentialsState()
        }
    }
    
    internal func isLoginButtonEnabled(_ flag: Bool) {
        if flag {
            rootView.userLoginButton.isEnabled = flag
        } else {
            rootView.userLoginButton.isEnabled = flag
        }
    }
    
    internal func isHiddenPasswordTextField(_ flag: Bool) {
        if flag {
            rootView.userPasswordTextField.isHidden = flag
            rootView.userAgreementTextView.isHidden = flag
        } else {
            rootView.userPasswordTextField.isHidden = flag
            rootView.userAgreementTextView.isHidden = flag
        }
    }
}

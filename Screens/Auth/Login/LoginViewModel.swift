import UIKit

internal protocol LoginViewModelInput: UITextFieldDelegate {
    var coordinator: LoginCoordinator? { get set }
    var output: LoginViewModelOutput? { get set }
    
    func userLoginButtonTap(_ phoneNumber: String?, _ password: String?)
    func userRegisterButtonTap()
    func userPassowrdTextFieldTextChanged(_ password: String?)
}

internal protocol LoginViewModelOutput: AnyObject {
    func isValidCredentials(_ flag: Bool)
    func isLoginButtonEnabled(_ flag: Bool)
    func loginButtonPressedState()
    func isHiddenPasswordTextField(_ flag: Bool)
}

internal final class LoginViewModel: BaseViewModel<LoginRepositoryProtocol> {
    internal var coordinator: LoginCoordinator?
    internal weak var output: LoginViewModelOutput?
    internal let keychainService: KeychainServiceProtocol
    
    internal init (keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }
}

extension LoginViewModel: LoginViewModelInput {
    internal func userRegisterButtonTap() {
        coordinator?.registerPage()
    }
    
    internal func userLoginButtonTap(_ phoneNumber: String?, _ password: String?) {
        output?.loginButtonPressedState()
        
        guard let phoneNumber = phoneNumber else { return }
        guard let password = password else { return }
        
        let splitPhoneNumber = phoneNumber.removingWhiteSpaces()
        let validPhoneNumber = String(splitPhoneNumber.dropFirst())

        repository.login(phoneNumber: validPhoneNumber, password: password) { [weak self] result in
            switch result {
            case .success(let token):
                try? self?.keychainService.set(token, for: KeychainKeys.accessToken)
                UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                DispatchQueue.main.async {
                    self?.output?.isValidCredentials(true)
                    self?.coordinator?.navigateToMainPage()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.output?.isValidCredentials(false)
                    self?.output?.isLoginButtonEnabled(true)
                }
            }
        }
    }
    
    internal func userPassowrdTextFieldTextChanged(_ password: String?) {
        guard let password = password else { return }
        if password.count >= 6 { 
            output?.isLoginButtonEnabled(true)
            return
        }
        
        output?.isLoginButtonEnabled(false)
    }
}

extension LoginViewModel {
    internal func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for char in mask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewModel: UITextFieldDelegate {
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard (5..<16).contains(range.location), let text = textField.text else { return false }
        
        if range.location == 15 && string != "" {
            output?.isHiddenPasswordTextField(false)
        } else {
            output?.isHiddenPasswordTextField(true)
        }
        
        if range.location == 5 && string == "" {
            return true
        }
        
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+XXX XXX XXX XXX", phone: newString)
        return false
    }
}

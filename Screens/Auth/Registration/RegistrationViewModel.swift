import Foundation
import UIKit

internal protocol RegistrationViewModelOutput: AnyObject {
    func setRegistrationButtonEnabled(_ bool: Bool)
    func notSuitablePassword()
    func notSamePasswords()
    func clearErrors()

    func updatePhoneNumber(_ phoneNumber: String?)
    func updatePassword(_ password: String?)
    func updateRepeatPassword(_ repeatedPassword: String?)

    func showError(_ error: Error)
}

internal protocol RegistrationViewModelInput {
    var coordinator: RegisterCoordinator? { get set }
    var output: RegistrationViewModelOutput? { get set }
    
    func userRegisterButtonTap()

    func phoneNumberInputChanged(_ phoneNumber: String?)
    func passwordInputChanged(_ password: String?)
    func repeatedPasswordInputChanged(_ repeatedPassword: String?)

}

internal final class RegistrationViewModel: BaseViewModel<RegistrationRepositoryProtocol> {
    internal var coordinator: RegisterCoordinator?
    internal weak var output: RegistrationViewModelOutput? 
    private var phoneNumber: String?
    private var password: String?
    private var repeatedPassword: String?

}

extension RegistrationViewModel: RegistrationViewModelInput {

    func userRegisterButtonTap() {
        guard let phoneNumber = phoneNumber,
              let password = password,
              let repeatedPassword = repeatedPassword else { return }

        let validPhoneNumber = String(phoneNumber.removingWhiteSpaces().dropFirst())

        repository.registration(phoneNumber: validPhoneNumber, password: password, password2: repeatedPassword, completionHander: { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.coordinator?.navigateToOneTimePassword(phoneNumber: phoneNumber)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.output?.showError(error)
                }
            }
        })
    }

    func phoneNumberInputChanged(_ phoneNumber: String?) {
        let formatedString = format(with: "+XXX XXX XXX XXX", phone: phoneNumber ?? "")
        guard 4...16 ~= formatedString.count else { return }
        self.phoneNumber = formatedString
        output?.updatePhoneNumber(formatedString)
        validateInputs()
    }

    func passwordInputChanged(_ password: String?) {
        self.password = password
        output?.updatePassword(password)
        validateInputs()
    }

    func repeatedPasswordInputChanged(_ repeatedPassword: String?) {
        self.repeatedPassword = repeatedPassword
        output?.updateRepeatPassword(repeatedPassword)
        validateInputs()
    }
}

extension RegistrationViewModel {

    private func format(with mask: String, phone: String) -> String {
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

    private func validateInputs() {
        output?.clearErrors()

        guard phoneNumber?.count == 16 else {
            output?.setRegistrationButtonEnabled(false)
            return
        }

        guard let password = password else {
            output?.setRegistrationButtonEnabled(false)
            return
        }

        guard validatePassword(password) else {
            output?.notSuitablePassword()
            output?.setRegistrationButtonEnabled(false)
            return
        }

        guard let repeatedPassword = repeatedPassword else {
            output?.setRegistrationButtonEnabled(false)
            return
        }

        guard checkPasswords(password, repeatedPassword) else {
            output?.notSamePasswords()
            output?.setRegistrationButtonEnabled(false)
            return
        }

        output?.setRegistrationButtonEnabled(true)
    }

    private func validatePassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        if !NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: password) {
                return false
            }
            
            if !NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: password) {
                return false
            }
            
            if !NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: password) {
                return false
            }
            
            if password.count < 8 {
                return false
            }
            return true
    }
    
    private func checkPasswords(_ password: String?, _ repeatedPassword: String?) -> Bool {
        if password == repeatedPassword {
            return true
        } else {
            return false
        }
    }
}

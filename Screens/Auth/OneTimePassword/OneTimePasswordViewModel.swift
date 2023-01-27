import Foundation
import ObjectMapper

internal protocol OneTimePasswordViewModelOutput: AnyObject {
    func setOutputText(_ text: String)
    func setOutputButton(state: StateView)
}

internal protocol OneTimePasswordViewModelInput {
    var coordinator: RegisterCoordinator? { get set }
    var output: OneTimePasswordViewModelOutput? { get set }
    func runTimer()
    func loginButtonTap(oneTimePassword: String)
    func sendAgainButtonTap()
    func setPhoneNumber(phoneNumber: String)
}

internal final class OneTimePasswordViewModel: BaseViewModel<OneTimePasswordRepositoryProtocol> {
    // MARK: - Private properties
    private var timer: Timer = {
        let timer: Timer = .init()
        timer.tolerance = 0.1
        return timer
    }()
    private var timeLeft: UInt8 = 120
    private var isTimerRunning: Bool = false

    // MARK: - Internal properties
    internal var coordinator: RegisterCoordinator?
    internal weak var output: OneTimePasswordViewModelOutput?
    internal let keychainService: KeychainServiceProtocol
    private var phoneNumber: String?

    internal init(
        keychainService: KeychainServiceProtocol
    ) {
        self.keychainService = keychainService
    }
}

// MARK: - OneTimePasswordViewModelInput
extension OneTimePasswordViewModel: OneTimePasswordViewModelInput {
    // MARK: - Private methods
    private func timeString() -> String {
        let minutes: UInt8 = timeLeft / 60 % 60
        let seconds: UInt8 = timeLeft % 60
        let timeToString: String = .init(format: "%02i:%02i",
                                  minutes,
                                  seconds)
        return timeToString
    }
    
    private func resetTimer() {
        timer.invalidate()
        timeLeft = 120
        output?.setOutputText(timeString())
    }
    
    @objc
    private func onTimerFires() {
        if timeLeft <= 0 {
            output?.setOutputButton(state: .timeout)
            resetTimer()
        } else {
            timeLeft -= 1
        }
        output?.setOutputText(timeString())
    }

    // MARK: - Internal methods
    internal func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1,
                                      target: self,
                                      selector: (#selector(onTimerFires)),
                                      userInfo: nil, repeats: true)
    }
    
    internal func loginButtonTap(oneTimePassword: String) {

        guard let phoneNumber = phoneNumber else { return }

        let splitPhoneNumber = phoneNumber.removingWhiteSpaces()
        let validPhoneNumber = String(splitPhoneNumber.dropFirst())

        repository.checkOneTimePassword(phoneNumber: validPhoneNumber,
                                        oneTimePassword: oneTimePassword) { result in
            switch result {
            case .success(let model):
                try? self.keychainService.set(model, for: KeychainKeys.accessToken)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.coordinator?.navigateToMainPage()
                }
            case .failure:
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.output?.setOutputButton(state: .error)
                    self.resetTimer()
                }
            }
        }
    }

    internal func sendAgainButtonTap() {
        output?.setOutputButton(state: .normal)
        runTimer()
    }
    
    internal func setPhoneNumber(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}

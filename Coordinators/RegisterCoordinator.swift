import UIKit

public class RegisterCoordinator: BaseCoordinator {
    var navigationController: BaseNavigationController
    var parentCoordinator: AppCoordinator?
    public init(navigationController: BaseNavigationController, parentCoordinator: AppCoordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    public func start() {
        let registerPage: RegistrationController = .init()
        registerPage.viewModel.coordinator = self
        navigationController.pushViewController(registerPage, animated: true)
    }
    
    public func navigateToOneTimePassword(phoneNumber: String) {
        let controller: OneTimePasswordController = .init()
        controller.setPhoneNumber(phoneNumber: phoneNumber)
        controller.viewModel.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    public func navigateToMainPage() {
        parentCoordinator?.navigateToMain()
    }
}

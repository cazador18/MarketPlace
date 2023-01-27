import UIKit

public class LoginCoordinator: BaseCoordinator {
    var navigationController: BaseNavigationController
    
    var parentCoordinator: AppCoordinator?
    public init(navigationController: BaseNavigationController, parentCoordinator: AppCoordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    public func start() {
        let loginpage: LoginController = .init()
        loginpage.viewModel.coordinator = self
        navigationController.pushViewController(loginpage, animated: true)
    }
    
    public func registerPage() {
        parentCoordinator?.registerPage()
    }
    public func navigateToMainPage() {
        parentCoordinator?.navigateToMain()
    }
    
}

import UIKit
import Foundation

public class AppCoordinator: BaseCoordinator {
 
    var parentCoordinator: AppCoordinator?
    
    var navigationController: BaseNavigationController

    let keychainService: KeychainServiceProtocol

    init(navigationController: BaseNavigationController,
         keychainService: KeychainServiceProtocol) {
        self.navigationController = navigationController
        navigationController.showLaunchView()
        self.keychainService = keychainService
    }
    public func start() {
        if UserDefaults.standard.bool(forKey: "startPageShown") {
            navigateToMain()
        } else {
            let startPage: StartPageViewController = .init()
            startPage.viewModel.coordinator = self
            navigationController.pushViewController(startPage, animated: true)
            UserDefaults.standard.set(true, forKey: "startPageShown")
        }
    }
    
    public func loginPage() {
        let loginpage: LoginCoordinator = .init(navigationController:
                                        self.navigationController,
                                          parentCoordinator: self)
        loginpage.start()
    }
    
    public func registerPage() {
        let registerPage: RegisterCoordinator = .init(navigationController:
                                                        self.navigationController,
                                                      parentCoordinator: self)
        registerPage.start()
    }
    
    public func navigateToMain() {
        let mainPage: MainCoordinator = .init(navigationController: self.navigationController, parentCoordinator: self)
        mainPage.start()
    }
    public func myProfilePage() {
        let myprofile: MyProfileCoordinator = .init(parentCoordinator: self, navigationController: self.navigationController)
        myprofile.start()
    }
    public func newAdsPage() {
        let newAds: NewAdsCoordinator = .init(parentCoordinator: self, navigationController: self.navigationController)
        newAds.start()
    }
}

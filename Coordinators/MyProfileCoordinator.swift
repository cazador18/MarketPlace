import UIKit
internal class MyProfileCoordinator: BaseCoordinator {
    var navigationController: BaseNavigationController
    var parentCoordinator: AppCoordinator?
    internal init(parentCoordinator: AppCoordinator?, navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    internal func start() {
        let myProfilePage: MyProfileController = .init()
        myProfilePage.viewModel.coordinator = self
        navigationController.pushViewController(myProfilePage, animated: true)
    }
    internal func faqPage() {
        let faqPage: FAQViewController = .init()
        faqPage.viewModel.coordinator = self
        navigationController.pushViewController(faqPage, animated: true)
    }
    internal func editAdPage(with myAdModel: MyAds) {
        let editAdPage: EditAdCoordinator = .init(navigationController: navigationController)
        editAdPage.parentCoordinator = parentCoordinator
        editAdPage.startEditPage(with: myAdModel)
    }
}

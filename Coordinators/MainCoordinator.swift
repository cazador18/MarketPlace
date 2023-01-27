import UIKit

public class MainCoordinator: BaseCoordinator {
    var navigationController: BaseNavigationController
    
    var parentCoordinator: AppCoordinator?
    
    public init(navigationController: BaseNavigationController, parentCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    public func start() {
        let controller: MainViewController = .init()
        controller.viewModel.coordinator = self
        navigationController.viewControllers = [controller]

    }
    
    internal func navigateToMyProfilePage() {
        parentCoordinator?.myProfilePage()
    }
    
    internal func navigateToNewAdPage() {
        parentCoordinator?.newAdsPage()
    }

    internal func navigateToAdDetail(with uuid: String) {
        let adsDetailPage: AdDetailsController = .init()
        adsDetailPage.viewModel.adUuid = uuid
        adsDetailPage.viewModel.coordinator = self
        navigationController.pushViewController(adsDetailPage, animated: true)
    }
}

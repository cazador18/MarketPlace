import Foundation
import UIKit

protocol BaseCoordinator {
    var navigationController: BaseNavigationController { get set }
    var parentCoordinator: AppCoordinator? {get set }
    func start()
}

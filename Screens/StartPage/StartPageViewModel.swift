import Foundation
import UIKit

protocol StartPageViewModelInput {

    var image: UIImage { get }
    var title: String { get }
    var body: String { get }
    var buttonTitle: String { get }
    var coordinator: AppCoordinator? {get set }
    func performAction()
}

internal class StartPageViewModel: StartPageViewModelInput {
    var coordinator: AppCoordinator?
    let image = Asset.startPageIcon.image
    let title = "О!Маркет"
    let body = "Теперь у вас есть возможность публиковать и просматривать объявления в приложении Мой О!"
    let buttonTitle = "Перейти в маркет"

    internal func performAction() {
        coordinator?.loginPage()
    }
}

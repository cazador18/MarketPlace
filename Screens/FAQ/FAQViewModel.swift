import UIKit

internal protocol FAQViewModelInput {
    var coordinator: MyProfileCoordinator? { get set }
    var output: FAQViewModelOutput? { get set }
    var dataSource: FaqTableViewDataSorce {get set }
    func getFAQResult()
}
internal protocol FAQViewModelOutput: AnyObject {
    func viewUpdate()
}

internal final class FAQViewModel: BaseViewModel<FAQRepositoryProtocol> {
    var coordinator: MyProfileCoordinator?
    var dataSource: FaqTableViewDataSorce = .init()
    var output: FAQViewModelOutput?
}
extension FAQViewModel: FAQViewModelInput {
    func getFAQResult() {
        repository.getFAQResult { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.dataSource.setModel(model: model)
                    self.output?.viewUpdate()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

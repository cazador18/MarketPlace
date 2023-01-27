import Foundation

internal protocol CategoryChooseViewModelInput {
    var coordinator: AdCoordinator? { get set }
    var output: CategoryChooseOutput? { get set }
    var dataSource: CategoryChooseDataSource { get set }
    
    func getCategoryChooseResult()
    func didTapBackButton()
}

internal protocol CategoryChooseOutput: AnyObject {
    func viewUpdate()
}

internal final class CategoryChooseViewModel: BaseViewModel<MainRepositoryProtocol> {
    var coordinator: AdCoordinator?
    var dataSource: CategoryChooseDataSource = .init()
    var output: CategoryChooseOutput?
}

extension CategoryChooseViewModel: CategoryChooseViewModelInput {
    internal func getCategoryChooseResult() {
        repository.getCategoryList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.dataSource.setModel(model: model)
                    self.output?.viewUpdate()
                case .failure:
                    print("Error")
                }
            }
        }
    }
    
    internal func didTapBackButton() {
        coordinator?.popViewController()
    }
}

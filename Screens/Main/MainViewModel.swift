import UIKit

internal protocol MainViewModelInput {
    var coordinator: MainCoordinator? { get set }
    var output: MainViewModelOutput? { get set }
    var adsDataSource: AdCollectionViewDataSource { get set }
    var categoryDataSource: CategoryCollectionViewDataSource { get set }
    
    func getAdsList(page: String)
    func updateCategoryId(categoryId: Int)
    func updateSearchText(text: String)
    func getCategoryList()
}

internal protocol MainViewModelOutput: AnyObject {
    func viewUpdateAdCollectionView()
    func viewUpdateCategoryCollectionView()
    func closeSearchBar()
}

internal final class MainViewModelImpl: BaseViewModel<MainRepositoryProtocol> {
    // MARK: Properties
    internal var coordinator: MainCoordinator?
    internal weak var output: MainViewModelOutput?
    internal var adsDataSource: AdCollectionViewDataSource
    internal var categoryDataSource: CategoryCollectionViewDataSource
    private var adQueryParameters: AdQueryParameters = .init(queryType: .all)
    
    internal init(adsDataSource: AdCollectionViewDataSource,
                  categoryDataSource: CategoryCollectionViewDataSource) {
        self.adsDataSource = adsDataSource
        self.categoryDataSource = categoryDataSource
    }
}

// MARK: MainViewModelInput
extension MainViewModelImpl: MainViewModelInput {
    // MARK: Private Methods
    private func allAds(page: String) {
        repository.getAdsList(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.adsDataSource.setModel(model: model)
            case .failure(let error):
                self.adsDataSource.clean()
                print(error)
            }
            DispatchQueue.main.async {
                self.output?.viewUpdateAdCollectionView()
            }
        }
    }

    private func filteredAdsFromCategory(page: String) {
        guard let categoryId: Int = adQueryParameters.categoryId else { return }
        repository.getFilteredList(page: page, categoryId: categoryId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.adsDataSource.setModel(model: model)
            case .failure(let error):
                self.adsDataSource.clean()
                print(error)
            }
            DispatchQueue.main.async {
                self.output?.viewUpdateAdCollectionView()
            }
        }
    }
    
    private func filteredAdsFromTitle(page: String) {
        guard let text: String = adQueryParameters.text else { return }
        repository.getFilteredList(page: page, text: text,
                                   category: adQueryParameters.categoryId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.adsDataSource.setModel(model: model)
            case .failure(let error):
                self.adsDataSource.clean()
                print(error)
            }
            DispatchQueue.main.async {
                self.output?.viewUpdateAdCollectionView()
            }
        }
    }

    // MARK: Internal Methods
    internal func getAdsList(page: String) {

        if page == "1" {
            if adQueryParameters.queryType != .filterTitle {
                output?.closeSearchBar()
            }
            adsDataSource.clean()
        }

        switch adQueryParameters.queryType {
        case .all:
            allAds(page: page)
        case .filterTitle:
            filteredAdsFromTitle(page: page)
        case .filterCategory:
            filteredAdsFromCategory(page: page)
        }
    }
    
    internal func getCategoryList() {
        repository.getCategoryList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.categoryDataSource.setModel(model: model)
                DispatchQueue.main.async {
                    self.output?.viewUpdateCategoryCollectionView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    internal func updateCategoryId(categoryId: Int) {
        if categoryId == 0 {
            adQueryParameters = .init(queryType: .all, categoryId: categoryId, text: "")
        } else {
            adQueryParameters = .init(queryType: .filterCategory, categoryId: categoryId, text: "")
        }
        
        getAdsList(page: "1")
    }
    
    internal func updateSearchText(text: String) {
        if text == "" {
            adQueryParameters.queryType = .filterCategory
        } else {
            adQueryParameters.text = text
            adQueryParameters.queryType = .filterTitle
        }
    }
}

import Foundation

internal protocol MyProfileViewModelInput {
    var coordinator: MyProfileCoordinator? { get set }
    var output: MyProfileViewModelOutput? { get set }
    var myProfileCollectionDataSource: MyProfileCollectionViewDataSource { get set }
    func userFAQButtonTap()
    func fetchMyAds(page: String, segmentControlIndex: Int)
    func getMyAd(with myAd: MyAds)
}

internal protocol MyProfileViewModelOutput {
    func populateWith(ads: [MyAds]?, nextPage: Int?)
    func isEmptyAds(_ flag: Bool)
}

internal final class MyProfileViewModel: BaseViewModel<MyProfileRepositoryProtocol> {
    internal var coordinator: MyProfileCoordinator?
    internal var output: MyProfileViewModelOutput?
    internal var myProfileCollectionDataSource: MyProfileCollectionViewDataSource = .init()
}

extension MyProfileViewModel: MyProfileViewModelInput {
    private func getActiveAds(page: String) {
        repository.getActiveAds(page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    guard let myAds = model.results, myAds.count > 0 else {
                        self?.output?.isEmptyAds(true)
                        return
                    }
                    self?.output?.populateWith(ads: myAds, nextPage: model.next)
                case .failure:
                    self?.output?.isEmptyAds(true) }
            }
        }
    }
    
    private func getInActiveAds(page: String) {
        repository.getDisabledAds(page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    guard let myAds = model.results, myAds.count > 0 else {
                        self?.output?.isEmptyAds(true)
                        return
                    }
                    self?.output?.populateWith(ads: myAds, nextPage: model.next)
                case .failure:
                    self?.output?.isEmptyAds(true) }
            }
        }
    }
    
    internal func getMyAd(with myAd: MyAds) {
            coordinator?.editAdPage(with: myAd)
        }

    internal func fetchMyAds(page: String, segmentControlIndex: Int) {
        switch segmentControlIndex {
        case 0:
            getActiveAds(page: page)
        case 1:
            getInActiveAds(page: page)
        default:
            return
        }
    }
    internal func userFAQButtonTap() {
        coordinator?.faqPage()
    }
}

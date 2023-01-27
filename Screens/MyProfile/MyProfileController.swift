import UIKit

internal final class MyProfileController: VMController<MyProfilePresentable, MyProfileViewModelInput> {
    internal override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мой профиль"
        navigationController?.navigationBar.backIndicatorImage = Asset.magentaBackButton.image
    }

    internal override func onConfigureViewModel() {
        viewModel.output = self
    }

    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.refreshMyAds()
    }

    internal override func onConfigureActions() {
        let rightButton = UIBarButtonItem(image: UIImage(named: "FAQButton"), style: .plain, target: self, action: #selector(userFAQButtonPressed))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    internal override func onConfigureController() {
        rootView.dataSource.selectMyAdAction = viewModel.getMyAd
        rootView.dataSource.changePage = viewModel.fetchMyAds
    }
}

extension MyProfileController: MyProfileViewModelOutput {
    internal func populateWith(ads: [MyAds]?, nextPage: Int?) {
        if let ads = ads {
            DispatchQueue.main.async { [weak self] in
                self?.rootView.populateDataSource(ads: ads, nextPage: nextPage)
            }
        }
    }
    internal func isEmptyAds(_ flag: Bool) {
        if flag {
            DispatchQueue.main.async { [weak self] in
                self?.rootView.showEmptyAdsState()
            }
        }
    }
    
}
extension MyProfileController {
    @objc private func userFAQButtonPressed() {
        viewModel.userFAQButtonTap()
    }
}

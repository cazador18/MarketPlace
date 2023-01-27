import UIKit

internal final class MainViewController: VMController<MainViewPresentable, MainViewModelInput> {
    private var timer: Timer = .init()
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.hideViews(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.backIndicatorImage = Asset.magentaBackButton.image
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: Internal Methods
    internal override func onConfigureController() {
        rootView.configCollectionView(adDataSource: viewModel.adsDataSource,
                                      categoryDataSource: viewModel.categoryDataSource,
                                      searchBarDelegate: self)
    }
    
    internal override func onConfigureViewModel() {
        viewModel.getAdsList(page: "1")
        viewModel.output = self
        viewModel.getCategoryList()
        viewModel.adsDataSource.selectAction = viewModel.coordinator?.navigateToAdDetail
        viewModel.categoryDataSource.selectCategoryAction = viewModel.updateCategoryId
        viewModel.adsDataSource.changePage = viewModel.getAdsList
    }
    
    internal override func onConfigureActions() {
        rootView.myProfileButtonAction = viewModel.coordinator?.navigateToMyProfilePage
        rootView.addAdsButtonAction = viewModel.coordinator?.navigateToNewAdPage
        rootView.refreshDataAction = viewModel.getAdsList
    }
    
    internal override func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: MainViewModelOutput
extension MainViewController: MainViewModelOutput {
    internal func viewUpdateAdCollectionView() {
        rootView.adCollectionViewReloadData()
    }
    
    internal func viewUpdateCategoryCollectionView() {
        rootView.categoryCollectionViewReloadData()
    }
    
    internal func closeSearchBar() {
        rootView.closeSearchBar()
    }
}

// MARK: UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer.invalidate()
        timer = .scheduledTimer(withTimeInterval: 0.5, repeats: false) { [viewModel] _ in
            if searchText.count > 1 {
                viewModel.updateSearchText(text: searchText)
                viewModel.getAdsList(page: "1")
            }
            
            if searchText.isEmpty || searchText == "" {
                viewModel.updateSearchText(text: "")
                viewModel.getAdsList(page: "1")
            }
        }
    }
    
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

}

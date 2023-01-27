import UIKit
import PhotosUI

internal class EditAdCoordinator: AdCoordinator {
    internal var navigationController: BaseNavigationController
    internal var parentCoordinator: AppCoordinator?
    
    // MARK: Actions
    private var dataSource: AddImageCollectionViewDataSource?
    
    internal var selectedCategoryAction: ((Category) -> Void)?
    internal var selectedDealAction: ((String?) -> Void)?
    internal var selectedCurrencyAction: ((String?) -> Void)?
    
    internal init(parentCoordinator: AppCoordinator? = nil, navigationController: BaseNavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    internal func start() {}
    internal func startEditPage(with myModel: MyAds) {
        let page: EditAdViewController = .init()
        page.viewModel.coordinator = self
        page.viewModel.adModel = myModel
        navigationController.pushViewController(page, animated: true)
    }
    
    internal func chooseImageTypeAlert(dataSource: AddImageCollectionViewDataSource) {
        self.dataSource = dataSource
        
        let alertController = UIAlertController(title: "Выберите источник фото", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: .default, handler: {_ in
            self.openCamera()
        })
        let galleryAction = UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.openGallery()
        })
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        [cameraAction, galleryAction, cancelAction].forEach {
            alertController.addAction($0)
        }
        
        navigationController.present(alertController, animated: true)
    }
    
    internal func openCamera() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = dataSource
        navigationController.present(imagePickerController, animated: true)
    }
    
    internal func openGallery() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 10
        let imagePickerController = PHPickerViewController(configuration: configuration)
        imagePickerController.delegate = dataSource
        navigationController.present(imagePickerController, animated: true)
    }
    
    internal func presentChooseDealType() {
        let dealTypeViewController = DealTypeSelectionController()
        dealTypeViewController.modalPresentationStyle = .overCurrentContext
        dealTypeViewController.delegate = self
        navigationController.present(dealTypeViewController, animated: false)
    }
    
    internal func presentChooseCurrencyType() {
        let currencyTypeViewController = CurrencyTypeSelectionController()
        currencyTypeViewController.modalPresentationStyle = .overCurrentContext
        currencyTypeViewController.delegate = self
        navigationController.present(currencyTypeViewController, animated: false)
    }
    
    internal func presentChooseCategoryType() {
        let chooseCategoryViewController: CategoryChooseController = .init()
        chooseCategoryViewController.viewModel.coordinator = self
        chooseCategoryViewController.delegate = self
        navigationController.pushViewController(chooseCategoryViewController, animated: true)
    }
    
    internal func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
// MARK: - DealTypeSelectionDelegate

extension EditAdCoordinator: CategorySelectionDelegate {
    internal func didSelectCategory(_ category: Category?) {
        if let category = category {
            selectedCategoryAction?(category)
            self.popViewController()
        }
    }
}

extension EditAdCoordinator: DealTypeSelectionDelegate {
    internal func didSelectDeal(_ deal: String?) {
        selectedDealAction?(deal)
    }
}

// MARK: - CurrencyTypeSelectionDelegate

extension EditAdCoordinator: CurrencyTypeSelectionDelegate {
    internal func didSelectCurrency(_ currency: String?) {
        selectedCurrencyAction?(currency)
    }
}

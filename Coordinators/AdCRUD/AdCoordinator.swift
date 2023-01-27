internal protocol AdCoordinator: BaseCoordinator {
    var selectedCategoryAction: ((Category) -> Void)? { get set }
    var selectedDealAction: ((String?) -> Void)? { get set }
    var selectedCurrencyAction: ((String?) -> Void)? { get set }
    
    
    func chooseImageTypeAlert(dataSource: AddImageCollectionViewDataSource)
    func openCamera()
    func openGallery()
    func presentChooseDealType()
    func presentChooseCurrencyType()
    func presentChooseCategoryType()
    func popViewController()
}

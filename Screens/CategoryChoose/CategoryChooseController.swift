import UIKit

internal protocol CategorySelectionDelegate: AnyObject {
    func didSelectCategory(_ category: Category?)
}

internal class CategoryChooseController: VMController <CategoryChoosePresentable, CategoryChooseViewModelInput> {
    
    internal weak var delegate: CategorySelectionDelegate?
    
    internal override func onConfigureActions() {
        rootView.backButtonAction = viewModel.didTapBackButton
    }
    
    override func onConfigureViewModel() {
        rootView.configureDataSource(dataSource: viewModel.dataSource)
        viewModel.dataSource.didSelectCategoryAction = didSelectCategory(_:)
        viewModel.getCategoryChooseResult()
        viewModel.output = self
    }
    
    override func onConfigureController() {
        title = "Категория"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rootView.backButton)
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(rootView, selector: #selector(rootView.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(rootView, selector: #selector(rootView.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    internal override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(rootView, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(rootView, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    internal func didSelectCategory(_ category: Category?) {
        delegate?.didSelectCategory(category)
    }
}

extension CategoryChooseController: CategoryChooseOutput {
    func viewUpdate() {
        rootView.updateTableView()
    }
}

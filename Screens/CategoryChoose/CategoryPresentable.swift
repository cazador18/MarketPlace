import Foundation
import UIKit

internal final class CategoryChoosePresentable: BaseView {
    private let tableView: UITableView = .init()
    private lazy var searchBar: UISearchBar = .init()
    private let label: UILabel = .init()
    private let shimmerView = CategoryChooseShimmerView()

    internal let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    // MARK: - Actions
    
    internal var backButtonAction: (() -> Void)?

    private func configureSearchBar() {
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.placeholder = "Поиск в Бишкеке"
    }

    private func configureLabel() {
        label.text = "Категория"
    }
    
    override func onAddSubViews() {
        addSubview(tableView)
        addSubview(label)
        addSubview(searchBar)
        addSubview(shimmerView)
    }
    
    override func onConfigureView() {
        configureLabel()
        configureSearchBar()
        backgroundColor = Asset.backgroundColor.color
        tableView.register(CategoryChooseCustomTableViewCell.self, forCellReuseIdentifier: "cell")
        
        backButton.setImage(UIImage(named: "filterSearchBackButton"), for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    internal func configureDataSource(dataSource: CategoryChooseDataSource) {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
    
    internal func updateTableView() {
        tableView.reloadData()
        if self.tableView.numberOfSections > 0 {
            shimmerView.removeFromSuperview()
        }
    }
    
    
    @objc internal func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        _ = keyboardSize?.height ?? 0

        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.tableView.superview?.layoutIfNeeded()
        })
    }

    @objc internal func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.tableView.superview?.layoutIfNeeded()
        }
    }
    
    @objc private func didTapBackButton() {
        backButtonAction?()
    }
    
    override func onSetUpConstraints() {
        searchBar.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(0)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })
        label.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(60)
            $0.leading.equalTo(snp.leading).offset(16)
            $0.trailing.equalTo(snp.trailing).offset(-16)
        })
        tableView.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(100)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().offset(-28)
        })
        shimmerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

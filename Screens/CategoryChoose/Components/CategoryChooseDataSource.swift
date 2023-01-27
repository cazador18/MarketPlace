import UIKit

final internal class CategoryChooseDataSource: NSObject, UITableViewDataSource {
    private var model: ResultCategory?
    private let cellID: String
    
    // MARK: - Actions
    
    internal var didSelectCategoryAction: ((Category) -> Void)?
    
    // MARK: Initialize
    override init() {
        cellID = "cell"
    }
    // MARK: Internal Methods
    internal func setModel(model: ResultCategory) {
        self.model = model
    }
    // MARK: dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CategoryChooseCustomTableViewCell
        let model = model?.result?[indexPath.row]
        cell.updateTitle(title: model?.name ?? "error")
        cell.updateImage(image: model?.iconImg ?? "error")
        return cell
    }
}

// MARK: - UITableViewDataSource

extension CategoryChooseDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCategory = model?.result?[indexPath.row] {
            didSelectCategoryAction?(selectedCategory)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

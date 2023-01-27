import UIKit

internal final class FaqTableViewDataSorce: NSObject, UITableViewDataSource {
    private var model: FAQResult?
    private let cellID: String
    internal var stateModelCount: Bool
    // MARK: Initialize
    override init() {
        cellID = "cell"
        stateModelCount = false
    }
    // MARK: Internal Methods
    internal func setModel(model: FAQResult) {
        self.model = model
        stateModelCount = true
    }
    // MARK: dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FAQTableViewCell
        let model = model?.results[indexPath.row]
        cell.updateTitleText(wuth: model?.title ?? "error")
        cell.updateDescriptionText(wuth: model?.content ?? "error")
        return cell
    }
}

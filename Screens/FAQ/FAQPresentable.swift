import UIKit
import SnapKit

internal final class FAQPresentable: BaseView {
    private let tableView: UITableView = .init()
    private let shimmerView: FAQShimmerView = .init()
    private var dataSource: FaqTableViewDataSorce?
    override func onAddSubViews() {
        addSubview(tableView)
        addSubview(shimmerView)
    }
    override func onConfigureView() {
        backgroundColor = UIColor(asset: Asset.backgroundColor)
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(asset: Asset.backgroundColor)
        tableView.register(FAQTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    internal func configTableViewDataSource(datasource: FaqTableViewDataSorce) {
        self.dataSource = datasource
        tableView.dataSource = self.dataSource
    }
    internal func tableViewReloadData() {
        if dataSource!.stateModelCount {
            shimmerView.removeFromSuperview()
        }
        tableView.reloadData()
    }
    override func onSetUpConstraints() {
        shimmerView.snp.makeConstraints {
            $0.centerX.equalTo(snp.centerX)
            $0.centerY.equalTo(snp.centerY)
            $0.height.equalTo(snp.height)
            $0.width.equalTo(snp.width)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(16)
            $0.leading.equalTo(snp.leading).offset(16)
            $0.trailing.equalTo(snp.trailing).offset(-16)
            $0.bottomMargin.equalTo(snp.bottomMargin).offset(-16)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FAQTableViewCell
        cell.hideDetailView()
    }
}
extension FAQPresentable: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            tableView.performBatchUpdates(nil)
        }
    }
}

import UIKit
import SnapKit

internal class FAQViewController: VMController <FAQPresentable, FAQViewModelInput> {
    override func onConfigureController() {
        rootView.configTableViewDataSource(datasource: viewModel.dataSource)
    }
    override func onConfigureViewModel() {
        viewModel.output = self
        viewModel.getFAQResult()
    }
}
extension FAQViewController: FAQViewModelOutput {
    func viewUpdate() {
        rootView.tableViewReloadData()
    }
}

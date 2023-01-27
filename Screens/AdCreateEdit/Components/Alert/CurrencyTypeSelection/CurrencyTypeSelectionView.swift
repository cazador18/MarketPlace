import UIKit

internal final class CurrencyTypeSelectionView: ModalTypeSelectionView {
    
    internal var currencyTypes: [String] = ["Сомы", "Доллары"]
    internal var somTableViewCell: SmallSpacingTableViewCell = .init()
    internal var dollarTableViewCell: SmallSpacingTableViewCell = .init()
    
    internal var selectedCurrencyType: ((String?) -> Void)?
    
    internal override func onConfigureView() {
        super.onConfigureView()
        
        actionsTableView.delegate = self
        actionsTableView.dataSource = self
        
        titleLabel.text = "Выберите валюту"
    }
}

extension CurrencyTypeSelectionView: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCurrencyType?(currencyTypes[indexPath.row])
        animateDismissGrayView()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CurrencyTypeSelectionView: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyTypes.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            somTableViewCell.mainLabel.text = currencyTypes[indexPath.row]
            return somTableViewCell
        case 1:
            dollarTableViewCell.mainLabel.text = currencyTypes[indexPath.row]
            return dollarTableViewCell
        default:
            return UITableViewCell()
        }
    }
}

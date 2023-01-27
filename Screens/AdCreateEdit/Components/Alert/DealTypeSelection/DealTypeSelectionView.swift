import UIKit

internal final class DealTypeSelectionView: ModalTypeSelectionView {
    
    internal var dealTypes: [String] = ["Купить", "Продать"]
    internal var buyTableViewCell: SmallSpacingTableViewCell = .init()
    internal var sellTableViewCell: SmallSpacingTableViewCell = .init()
    
    internal var selectedDealType: ((String?) -> Void)?
    
    internal override func onConfigureView() {
        super.onConfigureView()
        
        actionsTableView.delegate = self
        actionsTableView.dataSource = self
        
        titleLabel.text = "Тип сделки"
    }
}


extension DealTypeSelectionView: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDealType?(dealTypes[indexPath.row])
        animateDismissGrayView()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DealTypeSelectionView: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealTypes.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            buyTableViewCell.mainLabel.text = dealTypes[indexPath.row]
            return buyTableViewCell
        case 1:
            sellTableViewCell.mainLabel.text = dealTypes[indexPath.row]
            return sellTableViewCell
        default:
            return UITableViewCell()
        }
    }
}

import UIKit

internal protocol DealTypeSelectionDelegate: AnyObject {
    func didSelectDeal(_ deal: String?)
}

internal final class DealTypeSelectionController: ModalTypeSelectionController<DealTypeSelectionView> {
    
    internal weak var delegate: DealTypeSelectionDelegate?
    
    internal override func onConfigureActions() {
        super.onConfigureActions()
        rootView.selectedDealType = didSelectDeal
    }
    
    internal func didSelectDeal(_ deal: String?) {
        delegate?.didSelectDeal(deal)
    }
}

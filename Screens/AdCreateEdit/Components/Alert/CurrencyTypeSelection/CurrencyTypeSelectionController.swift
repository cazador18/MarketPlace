import UIKit

internal protocol CurrencyTypeSelectionDelegate: AnyObject {
    func didSelectCurrency(_ currency: String?)
}

internal final class CurrencyTypeSelectionController: ModalTypeSelectionController<CurrencyTypeSelectionView> {
    
    weak var delegate: CurrencyTypeSelectionDelegate?
    
    override func onConfigureActions() {
        super.onConfigureActions()
        rootView.selectedCurrencyType = didSelectCurrency
    }
    
    internal func didSelectCurrency(_ currency: String?) {
        delegate?.didSelectCurrency(currency)
    }
    
}

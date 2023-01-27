import UIKit

internal class ModalTypeSelectionController<T: ModalTypeSelectionView>: BaseViewController<T> {
    internal override func onConfigureActions() {
        rootView.dismissAction = dismissController
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()

        rootView.setupTapGesture()
        rootView.setupPanGesture()
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.animateShowGrayView()
    }
    
    internal override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootView.animatePresentContainer()
    }
    
    internal func dismissController() {
        self.dismiss(animated: false)
    }
}

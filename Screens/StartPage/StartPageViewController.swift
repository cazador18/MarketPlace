import Foundation
import UIKit

class StartPageViewController: VMController<StartPageView,
                                StartPageViewModelInput> {

    internal override func onConfigureViewModel() {
        rootView.imageView.image = viewModel.image
        rootView.primaryLabel.text = viewModel.title
        rootView.secondaryLabel.text = viewModel.body
        rootView.primaryButton.setTitle(viewModel.buttonTitle, for: .normal)
    }

    internal override func onConfigureActions() {
        rootView.primaryButton.addTarget(
            self,
            action: #selector(primaryButtonTouchUpInside),
            for: .touchUpInside)
    }

    @objc private func primaryButtonTouchUpInside(_ button: UIButton) {
        viewModel.performAction()
    }
}

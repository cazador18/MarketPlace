import Foundation
import UIKit

internal class AdDetailsController: VMController<AdDetailsPresentable, AdDetailsViewModelInput> {

    let networkManager = NetworkManager()
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.sections.isEmpty {
            viewModel.fetchData { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    let alertController = UIAlertController(title: "Ошибка",
                                                            message: error.localizedDescription,
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true)
                } else {
                    self.rootView.sections = self.viewModel.sections
                    self.rootView.sliderView.imageUrls = self.viewModel.fullImageUrls
                }
            }
        }
    }

    internal override func onConfigureController() {
        super.onConfigureController()
        self.rootView.fullScreenImagesPresented = { [weak self] enteredFullScreen in
            if enteredFullScreen {
                self?.navigationController?.setNavigationBarHidden(true, animated: false)
            } else {
                self?.navigationController?.setNavigationBarHidden(false, animated: false)
            }
        }
    }

    internal override func onConfigureActions() {
        super.onConfigureActions()
        rootView.messageButton.addTarget(self, action: #selector(messageButtonTapped), for: .touchUpInside)
        rootView.callButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
    }

    @objc func messageButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        viewModel.messagingMethods.forEach { method in
            switch method {
            case .whatsapp(let action):
                let alertAction = UIAlertAction(title: "WhatsApp", style: .default) { _ in
                    action()
                }
                alert.addAction(alertAction)
            case .telegram(let action):
                let alertAction = UIAlertAction(title: "Telegram", style: .default) { _ in
                    action()
                }
                alert.addAction(alertAction)
            }
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }

    @objc func callButtonTapped() {
        viewModel.call()
    }
}

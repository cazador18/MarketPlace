import UIKit

enum ControllerType {
    case magenta
    case dark
}

open class BaseNavigationController: UINavigationController {
    
    // MARK: - Properties
    
    var someImage: UIImage?
    var controllerType: ControllerType = .dark
    
    // MARK: - Life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        switch controllerType {
        case .magenta:
            someImage = Asset.magentaBackButton.image
        case .dark:
            someImage = Asset.blackBackButton.image
        }
        someImage = someImage?.stretchableImage(withLeftCapWidth: 32, topCapHeight: 32)
        UINavigationBar.appearance().backIndicatorImage = someImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = someImage
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
    }
}

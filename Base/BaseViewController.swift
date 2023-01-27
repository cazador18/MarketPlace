import UIKit

public protocol BaseViewModelProtocolExample {}

open class BaseViewController<View: UIView>: UIViewController {
    internal var rootView: View {
        view as! View
    }

    open override func loadView() {
        view = View()
        
        onConfigureController()
        onConfigureViewModel()
        onConfigureActions()
        hideKeyboardWhenTappedAround()
    }
    
    open func onConfigureController() {
        
    }
    
    open func onConfigureViewModel() {
        
    }
    
    open func onConfigureActions() {
        
    }
}

open class VMController<View: UIView, VMInput>: BaseViewController<View> {
    open lazy var viewModel: VMInput = Swinjectable.container.resolve(VMInput.self)!
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.resignFirstResponder()
    }
}

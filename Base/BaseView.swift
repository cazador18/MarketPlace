import Foundation
import UIKit

protocol BaseViewProtocol {}
open class BaseView: UIView {
    public override init(frame: CGRect) {
        super .init(frame: frame)
        
        onAddSubViews()
        onConfigureView()
        onSetUpTargets()
        onSetUpConstraints()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    open func onConfigureView() {
        backgroundColor = .black
    }
    open func onAddSubViews() {
        
    }
    open func onSetUpConstraints() {
        
    }
    open func onSetUpTargets() {
        
    }
}

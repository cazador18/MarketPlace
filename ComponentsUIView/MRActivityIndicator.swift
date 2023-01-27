import UIKit
internal class MRActivityIndicator: UIView {
    
    private var spinnerBehavior: UIDynamicItemBehavior?
    private var animator: UIDynamicAnimator?
    private var imageView: UIImageView?
    private var loaderImageName = ""
        
    internal func show(with image: String = Asset.ellipse.name) {
        loaderImageName = image
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            if self?.imageView == nil {
                self?.setupView()
                DispatchQueue.main.async {[weak self] in
                    self?.showLoadingActivity()
                }
            }
        }
    }
    internal func hide() {
        DispatchQueue.main.async {[weak self] in
            self?.stopAnimation()
        }
    }
    
    private func setupView() {

        let theImage = UIImage(named: loaderImageName)
        imageView = UIImageView(image: theImage)
        imageView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        if let imageView = imageView {
            self.spinnerBehavior = UIDynamicItemBehavior(items: [imageView])
        }
        animator = UIDynamicAnimator(referenceView: self)
    }
    
    private func showLoadingActivity() {
        if let imageView = imageView {
            addSubview(imageView)
            startAnimation()
//            UIApplication.shared.windows.first?.addSubview(self)
        }
    }
    
    private func startAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0 * CGFloat(Double.pi/180)
        rotationAnimation.toValue = 360 * CGFloat(Double.pi/180)
            rotationAnimation.duration = Double(1.6)
                rotationAnimation.repeatCount = HUGE
        self.imageView!.layer.add(rotationAnimation, forKey: "ellipse")
    }
    
    private func stopAnimation() {
        animator?.removeAllBehaviors()
        imageView?.isHidden = true
        imageView = nil
    }
}

import UIKit

extension UIColor {
    func pointImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1.0, height: 1.0), false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()
        self.setFill()
        context?.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}

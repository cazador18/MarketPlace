import Foundation
import UIKit

internal extension UIImage {
    func resizedImageForNetworkTransmission() -> UIImage {
        let maxSize: CGFloat = 2000
        if size.height > maxSize || size.width > maxSize {
            let newX, newY: CGFloat
            if size.width > size.height {
                newX = maxSize
                newY = size.height * newX / size.width
            } else {
                newY = maxSize
                newX = size.width * newY / size.height
            }
            let newSize = CGSize(width: newX, height: newY)
            UIGraphicsBeginImageContext(newSize)
            defer { UIGraphicsEndImageContext() }
            self.draw(in: CGRect(origin: .zero, size: newSize))
            return UIGraphicsGetImageFromCurrentImageContext() ?? self
        } else {
            return self
        }
    }
}

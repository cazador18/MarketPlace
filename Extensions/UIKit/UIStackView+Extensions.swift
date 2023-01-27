import Foundation
import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.lazy.forEach { addArrangedSubview($0) }
    }
}

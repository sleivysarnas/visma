import UIKit

extension UIView {
    func roundCorners(_ corners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.maskedCorners = corners
    }
}

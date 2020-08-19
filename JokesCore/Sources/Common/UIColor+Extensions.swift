import UIKit

public extension UIColor {
    
    static var defaultBackground: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
}

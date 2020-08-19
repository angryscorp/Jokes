import UIKit

public extension UIViewController {
    
    func wrapIntoNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
}

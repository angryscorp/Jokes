import UIKit

public protocol RootRouting {
    
    func attachRandomJokes(_ handler: (UIViewController) -> Void)
    
    func attachMyJokes(_ handler: (UIViewController) -> Void)
    
    func attachSettings(_ handler: (UIViewController) -> Void)
    
}

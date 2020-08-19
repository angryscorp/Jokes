import UIKit

public final class RootRouter {
    
    private let makeRandomJokes: () -> UIViewController
    private let makeMyJokes: () -> UIViewController
    private let makeSettings: () -> UIViewController
    
    public init(
        makeRandomJokes: @escaping () -> UIViewController,
        makeMyJokes: @escaping () -> UIViewController,
        makeSettings: @escaping () -> UIViewController
    ) {
        self.makeRandomJokes = makeRandomJokes
        self.makeMyJokes = makeMyJokes
        self.makeSettings = makeSettings
    }
}

extension RootRouter: RootRouting {
    
    public func attachRandomJokes(_ handler: (UIViewController) -> Void) {
        handler(makeRandomJokes())
    }
    
    public func attachMyJokes(_ handler: (UIViewController) -> Void) {
        handler(makeMyJokes())
    }
    
    public func attachSettings(_ handler: (UIViewController) -> Void) {
        handler(makeSettings())
    }
}

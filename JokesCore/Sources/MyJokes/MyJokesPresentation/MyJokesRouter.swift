import UIKit

public final class MyJokesRouter {
    
    private let makeNewJoke: () -> UIViewController
    
    public init(makeNewJoke: @escaping () -> UIViewController) {
        self.makeNewJoke = makeNewJoke
    }
}

extension MyJokesRouter: MyJokesRouting {
    
    public func attachNewJoke(_ handler: (UIViewController) -> Void) {
        handler(makeNewJoke())
    }
}

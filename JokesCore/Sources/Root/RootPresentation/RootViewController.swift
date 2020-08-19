import UIKit

public final class RootViewController: UITabBarController {
    
    private let router: RootRouting
    private let properties: RootProperties
    
    public init(router: RootRouting, properties: RootProperties) {
        self.router = router
        self.properties = properties
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        attachChildren()
    }
    
    private func attachChildren() {
        router.attachRandomJokes { [weak self] viewController in
            viewController.tabBarItem = .init(
                title: properties.tabRandomJokesTitle,
                image: properties.tabRandomJokesImage,
                tag: 0
            )
            self?.addChild(viewController)
        }
        router.attachMyJokes { [weak self] viewController in
            viewController.tabBarItem = .init(
                title: properties.tabMyJokesTitle,
                image: properties.tabMyJokesImage,
                tag: 1
            )
            self?.addChild(viewController)
        }
        router.attachSettings { [weak self] viewController in
            viewController.tabBarItem = .init(
                title: properties.tabSettingsTitle,
                image: properties.tabSettingsImage,
                tag: 2
            )
            self?.addChild(viewController)
        }
    }
}

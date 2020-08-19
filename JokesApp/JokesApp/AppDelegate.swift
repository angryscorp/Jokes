import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if window == nil {
            window = UIWindow()
        }
        
        window?.rootViewController = RootComponent(configuration: Self.configuration).makeRoot()
        window?.makeKeyAndVisible()
        
        return true
    }
}

private extension AppDelegate {
    
    static var configuration: Configuration {
        #if DEV
            return DevelopmentConfiguration()
        #else
            return ProductionConfiguration()
        #endif
    }
}

import Common
import RandomJokesData
import RandomJokesDomain
import RandomJokesInteracting
import RandomJokesPresentation
import UIKit

struct RandomJokesComponent {
    
    let parent: RootComponent
    let randomJokesStore: RandomJokesStore = RandomJokesStoreImpl()
    
    func makeRandomJokes() -> UIViewController {
        let properties = RandomJokesProperties(
            title: LocalizedString("title"),
            commonError: LocalizedString("commonError"),
            emptyCacheError: LocalizedString("emptyCacheError"),
            errorAlertTitle: LocalizedString("errorAlertTitle"),
            alertButtonTitle: LocalizedString("alertButtonTitle"),
            likeButtonTitle: LocalizedString("likeButtonTitle"),
            shareButtonTitle: LocalizedString("shareButtonTitle")
        )
        
        let cacheDataStore = CacheDataStoreImpl(userDefaults: .standard)
        
        let gateway = RandomJokesGatewayImpl(
            session: .shared,
            randomJokesURL: parent.configuration.randomJokesURL,
            randomJokesStore: randomJokesStore,
            cacheDataStore: cacheDataStore,
            settingsStore: parent.settingsStore
        )
        
        let interactor = RandomJokesInteractor(
            gateway: gateway,
            randomJokesStore: randomJokesStore,
            myJokesStore: parent.myJokesStore,
            settingsStore: parent.settingsStore
        )
        
        return RandomJokesViewController(
            properties: properties,
            interactor: interactor,
            state: interactor.state.asUnsafeDriver()
        ).wrapIntoNavigationController()
    }
    
    private func LocalizedString(_ key: String) -> String {
        NSLocalizedString(key, tableName: "RandomJokes", comment: "")
    }
}

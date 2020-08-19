import MyJokesData
import MyJokesDomain
import RandomJokesInteracting
import RootPresentation
import SettingsData
import SettingsDomain
import UIKit

struct RootComponent {
    
    let configuration: Configuration
    let settingsStore: SettingsStore = SettingsStoreImpl(userDefaults: .standard)
    let myJokesStore: MyJokesStore = MyJokesStoreImpl(userDefaults: .standard)
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    func makeRoot() -> UIViewController {
        let properties = RootProperties(
            tabRandomJokesTitle: LocalizedString("tabRandomJokesTitle"),
            tabRandomJokesImage: JokesImages.feed,
            tabMyJokesTitle: LocalizedString("tabMyJokesTitle"),
            tabMyJokesImage: JokesImages.favorites,
            tabSettingsTitle: LocalizedString("tabSettingsTitle"),
            tabSettingsImage: JokesImages.settings
        )
        
        let router = RootRouter(
            makeRandomJokes: { RandomJokesComponent(parent: self).makeRandomJokes() },
            makeMyJokes: { MyJokesComponent(parent: self).makeMyJokes() },
            makeSettings: { SettingsComponent(parent: self).makeSettings() }
        )
        
        return RootViewController(router: router, properties: properties)
    }
    
    private func LocalizedString(_ key: String) -> String {
        NSLocalizedString(key, tableName: "Root", comment: "")
    }

}

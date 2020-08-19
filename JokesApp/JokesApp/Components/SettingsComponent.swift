import Common
import SettingsInteracting
import SettingsPresentation
import UIKit

struct SettingsComponent {
    
    let parent: RootComponent
    
    func makeSettings() -> UIViewController {
        let properties = SettingsProperties(
            title: LocalizedString("title"),
            offlineModeTitle: LocalizedString("offlineModeTitle"),
            lastNameTitle: LocalizedString("lastNameTitle"),
            firstNameTitle: LocalizedString("firstNameTitle"),
            lastNamePlaceholder: LocalizedString("lastNamePlaceholder"),
            firstNamePlaceholder: LocalizedString("firstNamePlaceholder")
        )
        
        let interactor = SettingsInteractor(store: parent.settingsStore)
        
        return SettingsViewController(
            properties: properties,
            interactor: interactor,
            state: interactor.state.asUnsafeDriver()
        ).wrapIntoNavigationController()
    }
    
    private func LocalizedString(_ key: String) -> String {
        NSLocalizedString(key, tableName: "Settings", comment: "")
    }
}

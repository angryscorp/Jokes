import Common
import NewJokeInteracting
import NewJokePresentation
import UIKit

struct NewJokeComponent {
    
    let parent: MyJokesComponent
    
    func makeNewJoke() -> UIViewController {
        let formatterString = LocalizedString("symbolCounterFormatter")
        let symbolCounterFormatter = { String(format: formatterString, arguments: [$0, $1]) }
        
        let properties = NewJokeProperties(
            title: LocalizedString("title"),
            saveButtonTitle: LocalizedString("saveButtonTitle"),
            cancelButtonTitle: LocalizedString("cancelButtonTitle"),
            symbolCounterFormatter: symbolCounterFormatter
        )
        
        let interactor = NewJokeInteractor(store: parent.parent.myJokesStore)
        
        return NewJokeViewController(
            properties: properties,
            interactor: interactor
        ).wrapIntoNavigationController()
    }
    
    private func LocalizedString(_ key: String) -> String {
        NSLocalizedString(key, tableName: "NewJoke", comment: "")
    }
}

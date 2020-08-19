import Common
import MyJokesInteracting
import MyJokesPresentation
import UIKit

struct MyJokesComponent {
    
    let parent: RootComponent
    
    func makeMyJokes() -> UIViewController {
        let properties = MyJokesProperties(
            title: LocalizedString("title"),
            addButtonImage: JokesImages.add,
            deleteButtonTitle: LocalizedString("deleteButtonTitle")
        )
        
        let interactor = MyJokesInteractor(store: parent.myJokesStore)
        
        let router = MyJokesRouter(makeNewJoke: { NewJokeComponent(parent: self).makeNewJoke() })
        
        return MyJokesViewController(
            properties: properties,
            interactor: interactor,
            state: interactor.state.asUnsafeDriver(),
            router: router
        ).wrapIntoNavigationController()
    }
    
    private func LocalizedString(_ key: String) -> String {
        NSLocalizedString(key, tableName: "MyJokes", comment: "")
    }
}

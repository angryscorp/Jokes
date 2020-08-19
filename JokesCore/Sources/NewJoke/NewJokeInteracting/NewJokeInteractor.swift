import MyJokesDomain

public final class NewJokeInteractor {
    
    private let store: MyJokesStore
    
    public init(store: MyJokesStore) {
        self.store = store
    }
}

extension NewJokeInteractor: NewJokeInteracting {
    
    public func saveJoke(_ text: String) {
        store.save(.init(text))
    }
}

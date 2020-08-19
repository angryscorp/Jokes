import MyJokesDomain
import RxSwift

public final class MyJokesInteractor {
    
    public let state: Observable<MyJokesState>
    
    private let partial = BehaviorSubject<PartialStateChange>(value: .reset)
    private let store: MyJokesStore
    private let disposeBag = DisposeBag()
    
    public init(store: MyJokesStore) {
        self.store = store
        
        let initial = MyJokesState()
        state = partial.scan(initial, accumulator: MyJokesState.reduce)
            .startWith(initial)
            .share(replay: 1, scope: .forever)
        
        bind()
    }
    
    private func bind() {
        store.jokes
            .subscribe(onNext: { [partial] in partial.onNext(.newJokes($0)) })
            .disposed(by: disposeBag)
    }
}

extension MyJokesInteractor: MyJokesInteracting {
    
    public func deleteJoke(by id: MyJoke.ID) {
        store.delete(by: id)
    }
}

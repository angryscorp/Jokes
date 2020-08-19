import MyJokesDomain
import RandomJokesDomain
import RxSwift
import SettingsDomain

public class RandomJokesInteractor {
    
    public let state: Observable<RandomJokesState>
    
    private let partial = PublishSubject<PartialStateChange>()
    private let gateway: RandomJokesGateway
    private let randomJokesStore: RandomJokesStore
    private let myJokesStore: MyJokesStore
    private let settingsStore: SettingsStore
    private let disposeBag = DisposeBag()
    
    public init(
        gateway: RandomJokesGateway,
        randomJokesStore: RandomJokesStore,
        myJokesStore: MyJokesStore,
        settingsStore: SettingsStore
    ) {
        self.gateway = gateway
        self.randomJokesStore = randomJokesStore
        self.myJokesStore = myJokesStore
        self.settingsStore = settingsStore
        
        let initial = RandomJokesState()
        state = partial.scan(initial, accumulator: RandomJokesState.reduce)
            .startWith(initial)
            .share(replay: 1, scope: .forever)
        
        bind()
    }
    
    private func bind() {
        randomJokesStore.jokes
            .subscribe(onNext: { [partial] in partial.onNext(.newJokes($0)) })
            .disposed(by: disposeBag)
    }
}

extension RandomJokesInteractor: RandomJokesInteracting {
    
    public func reloadFeed() {
        partial.onNext(.reset)
        partial.onNext(.loadingDidStart)
        gateway.reloadFeed(with: 15)
            .subscribe(onError: { [partial] in partial.onNext(.error($0))})
            .disposed(by: disposeBag)
    }
    
    public func loadNextJokes() {
        guard !settingsStore.isOfflineMode else {
            return
        }
        partial.onNext(.loadingDidStart)
        gateway.getRandomJokes(count: 10)
            .subscribe(onError: { [partial] in partial.onNext(.error($0))})
            .disposed(by: disposeBag)
    }
    
    public func likeJoke(with id: Int) {
        Observable.just(())
            .withLatestFrom(state)
            .compactMap { $0.jokes.first(where: { $0.id == id })?.text }
            .subscribe(onNext: { [myJokesStore] in myJokesStore.save(.init($0)) })
            .disposed(by: disposeBag)
    }
}

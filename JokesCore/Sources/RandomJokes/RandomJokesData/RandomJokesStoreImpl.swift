import RandomJokesDomain
import RxSwift

public final class RandomJokesStoreImpl: RandomJokesStore {
    
    public var jokes: Observable<[Joke]> { _jokes }
    
    private let _jokes = PublishSubject<[Joke]>()
    
    public init() { }
    
    public func save(_ jokes: [Joke]) {
        _jokes.onNext(jokes)
    }
}

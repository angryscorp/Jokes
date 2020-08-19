import RxSwift

public protocol RandomJokesStore {
    
    var jokes: Observable<[Joke]> { get }
    
    func save(_ jokes: [Joke])
}

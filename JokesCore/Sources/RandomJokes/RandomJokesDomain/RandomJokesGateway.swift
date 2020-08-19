import RxSwift

public protocol RandomJokesGateway {
    
    func getRandomJokes(count: Int) -> Completable
    
    func reloadFeed(with count: Int) -> Completable
}

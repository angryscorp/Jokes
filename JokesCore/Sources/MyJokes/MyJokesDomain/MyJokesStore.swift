import RxSwift

public protocol MyJokesStore {
    
    var jokes: Observable<[MyJoke]> { get }
    
    func save(_ joke: MyJoke)
    
    func delete(by id: MyJoke.ID)
    
}

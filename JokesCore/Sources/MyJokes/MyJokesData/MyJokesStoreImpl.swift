import Foundation
import MyJokesDomain
import RxCocoa
import RxSwift

public struct MyJokesStoreImpl: MyJokesStore {
    
    public var jokes: Observable<[MyJoke]> {
        userDefaults.rx
            .observe(Data.self, myJokesStoreKey)
            .compactMap { $0?.toJokes() }
            .startWith(restore())
    }
    
    private let userDefaults: UserDefaults
    private let myJokesStoreKey: String
    
    public init(userDefaults: UserDefaults, myJokesStoreKey: String? = nil) {
        self.userDefaults = userDefaults
        self.myJokesStoreKey = myJokesStoreKey ?? String(describing: Self.self)
    }
    
    public func save(_ joke: MyJoke) {
        let jokes = [joke] + restore()
        userDefaults.set(jokes.toData(), forKey: myJokesStoreKey)
    }
    
    public func delete(by id: MyJoke.ID) {
        let jokes = restore().filter { $0.id != id }
        userDefaults.set(jokes.toData(), forKey: myJokesStoreKey)
    }
    
    private func restore() -> [MyJoke] {
        let data = userDefaults.object(forKey: myJokesStoreKey) as? Data
        return data?.toJokes() ?? []
    }
}

private extension Data {
    
    func toJokes() -> [MyJoke] {
        (try? JSONDecoder().decode([MyJoke].self, from: self)) ?? []
    }
}


private extension Array where Element == MyJoke {
    
    func toData() -> Data {
        guard let data = try? JSONEncoder().encode(self) else {
            fatalError("Unexpected error on converting [MyJoke] to Data")
        }
        return data
    }
}

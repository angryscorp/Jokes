import Foundation
import RandomJokesDomain
import RxSwift
import SettingsDomain

private struct Response: Codable {
    let value: [Joke]
}

public final class RandomJokesGatewayImpl {
    
    private let session: URLSession
    private let randomJokesURL: URL
    private let randomJokesStore: RandomJokesStore
    private let cacheDataStore: CacheDataStore
    private let settingsStore: SettingsStore
    
    public init(
        session: URLSession,
        randomJokesURL: URL,
        randomJokesStore: RandomJokesStore,
        cacheDataStore: CacheDataStore,
        settingsStore: SettingsStore
    ) {
        self.session = session
        self.randomJokesURL = randomJokesURL
        self.randomJokesStore = randomJokesStore
        self.cacheDataStore = cacheDataStore
        self.settingsStore = settingsStore
    }
}

extension RandomJokesGatewayImpl: RandomJokesGateway {
    
    public func getRandomJokes(count: Int) -> Completable {
        getRandomJokes(with: makeURL(with: count))
    }
    
    public func reloadFeed(with count: Int) -> Completable {
        if settingsStore.isOfflineMode {
            return getRandomJokesFromCache()
        } else {
            cacheDataStore.reset()
            return getRandomJokes(with: makeURL(with: count))
        }
    }
    
    private func getRandomJokesFromCache() -> Completable {
        guard let joke = restoreCache().randomElement() else {
            return .error(RandomJokesError.emptyCache)
        }
        randomJokesStore.save([joke])
        return .empty()
    }
    
    private func makeURL(with count: Int) -> URL {
        let url = randomJokesURL.appendingPathComponent(String(count))
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = []
        settingsStore.firstName.map { urlComponents?.queryItems?.append(URLQueryItem(name: "firstName", value: $0)) }
        settingsStore.lastName.map { urlComponents?.queryItems?.append(URLQueryItem(name: "lastName", value: $0)) }
        
        guard let urlWithParameters = urlComponents?.url else {
            fatalError("Unexpected error on converting URLComponents to URL")
        }
        
        return urlWithParameters
    }
    
    private func getRandomJokes(with url: URL) -> Completable {
        Completable.create { [weak self] completable in
            self?.session.dataTask(with: url) { data, response, error in
                guard
                    let self = self,
                    error == nil,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    response.mimeType == "application/json",
                    let data = data,
                    let decodedResponse = try? JSONDecoder().decode(Response.self, from: data)
                else {
                    completable(.error(error ?? RandomJokesError.commonError))
                    return
                }
                
                self.updateCache(with: decodedResponse.value)
                self.randomJokesStore.save(decodedResponse.value)
                
                completable(.completed)
            }.resume()
            
            return Disposables.create {}
        }
    }
    
    private func restoreCache() -> [Joke] {
        guard
            let data = cacheDataStore.restore(),
            let jokes = try? JSONDecoder().decode([Joke].self, from: data)
        else {
            return []
        }
        return jokes
    }
    
    private func updateCache(with newJokes: [Joke]) {
        let jokes = restoreCache()
        guard let data = try? JSONEncoder().encode(jokes + newJokes) else {
            fatalError("Unexpected error on converting [Joke] to Data")
        }
        
        cacheDataStore.save(data: data)
    }
}

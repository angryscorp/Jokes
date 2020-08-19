import Foundation
import RandomJokesDomain

public struct CacheDataStoreImpl: CacheDataStore {
    
    private let userDefaults: UserDefaults
    private let cacheStoreKey: String
    
    public init(userDefaults: UserDefaults, cacheStoreKey: String? = nil) {
        self.userDefaults = userDefaults
        self.cacheStoreKey = cacheStoreKey ?? String(describing: Self.self)
    }
    
    public func reset() {
        userDefaults.set(nil, forKey: cacheStoreKey)
    }
    
    public func save(data: Data) {
        userDefaults.set(data, forKey: cacheStoreKey)
    }
    
    public func restore() -> Data? {
        userDefaults.object(forKey: cacheStoreKey) as? Data
    }
}

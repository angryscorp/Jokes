import Foundation

public protocol CacheDataStore {
    func reset()
    func save(data: Data)
    func restore() -> Data?
}

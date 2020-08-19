import Foundation

protocol Configuration {
    var baseURL: URL { get }
    var randomJokesPath: String { get }
    var randomJokesURL: URL { get }
}

extension Configuration {
    var randomJokesURL: URL { baseURL.appendingPathComponent(randomJokesPath) }
}

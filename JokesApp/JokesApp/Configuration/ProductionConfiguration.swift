import Foundation

struct ProductionConfiguration: Configuration {
    let baseURL: URL = "http://api.icndb.com/"
    let randomJokesPath = "jokes/random/"
}

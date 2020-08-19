import RandomJokesDomain

public struct RandomJokesState {
    public var jokes: [Joke] = []
    public var status: Status = .idle
}

public extension RandomJokesState {
    
    enum Status {
        case idle
        case error(Error)
        case loading
    }
}

extension RandomJokesState.Status: Equatable {
    
    public static func == (lhs: RandomJokesState.Status, rhs: RandomJokesState.Status) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
}

enum PartialStateChange {
    case loadingDidStart
    case newJokes([Joke])
    case error(Error)
    case reset
}

extension RandomJokesState {
    
    static func reduce(
        previus: RandomJokesState,
        change: PartialStateChange
    ) -> RandomJokesState {
        var state = previus
        switch change {
        case .newJokes(let jokes):
            state.jokes += jokes
            state.status = .idle
        case .error(let error):
            state.status = .error(error)
        case .loadingDidStart:
            state.status  = .loading
        case .reset:
            state.jokes = []
            state.status = .idle
        }
        return state
    }
}

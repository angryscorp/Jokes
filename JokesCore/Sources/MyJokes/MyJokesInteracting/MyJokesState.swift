import MyJokesDomain

public struct MyJokesState {
    public var jokes: [MyJoke] = []
}

enum PartialStateChange {
    case reset
    case newJokes([MyJoke])
}

extension MyJokesState {
    
    static func reduce(
        previus: MyJokesState,
        change: PartialStateChange
    ) -> MyJokesState {
        var state = previus
        switch change {
        case .reset:
            state.jokes = []
        case .newJokes(let jokes):
            state.jokes = jokes
        }
        return state
    }
}


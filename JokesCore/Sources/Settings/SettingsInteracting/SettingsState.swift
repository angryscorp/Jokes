public struct SettingsState {
    public var lastName: String?
    public var firstName: String?
    public var isOfflineMode: Bool
}

enum PartialStateChange {
    case lastNameDidChange(String?)
    case firstNameDidChange(String?)
    case offlineModeDidChange(Bool)
}

extension SettingsState {
    
    static func reduce(
        previus: SettingsState,
        change: PartialStateChange
    ) -> SettingsState {
        var state = previus
        switch change {
        case .lastNameDidChange(let newName):
            state.lastName = newName
        case .firstNameDidChange(let newName):
            state.firstName = newName
        case .offlineModeDidChange(let newValue):
            state.isOfflineMode = newValue
        }
        return state
    }
}

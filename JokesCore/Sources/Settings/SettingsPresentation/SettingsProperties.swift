public struct SettingsProperties {
    
    let title: String
    let offlineModeTitle: String
    let lastNameTitle: String
    let firstNameTitle: String
    let lastNamePlaceholder: String
    let firstNamePlaceholder: String
    
    public init(
        title: String,
        offlineModeTitle: String,
        lastNameTitle: String,
        firstNameTitle: String,
        lastNamePlaceholder: String,
        firstNamePlaceholder: String
    ) {
        self.title = title
        self.offlineModeTitle = offlineModeTitle
        self.lastNameTitle = lastNameTitle
        self.firstNameTitle = firstNameTitle
        self.lastNamePlaceholder = lastNamePlaceholder
        self.firstNamePlaceholder = firstNamePlaceholder
    }
}

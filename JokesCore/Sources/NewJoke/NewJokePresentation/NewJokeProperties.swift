public struct NewJokeProperties {
    
    let title: String
    let saveButtonTitle: String
    let cancelButtonTitle: String
    let symbolCounterFormatter: (Int, Int) -> String
    
    public init(
        title: String,
        saveButtonTitle: String,
        cancelButtonTitle: String,
        symbolCounterFormatter: @escaping (Int, Int) -> String
    ) {
        self.title = title
        self.saveButtonTitle = saveButtonTitle
        self.cancelButtonTitle = cancelButtonTitle
        self.symbolCounterFormatter = symbolCounterFormatter
    }
}

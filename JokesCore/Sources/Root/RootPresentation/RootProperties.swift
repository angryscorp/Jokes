import UIKit

public struct RootProperties {
    let tabRandomJokesTitle: String
    let tabRandomJokesImage: UIImage
    let tabMyJokesTitle: String
    let tabMyJokesImage: UIImage
    let tabSettingsTitle: String
    let tabSettingsImage: UIImage
    
    public init(
        tabRandomJokesTitle: String,
        tabRandomJokesImage: UIImage,
        tabMyJokesTitle: String,
        tabMyJokesImage: UIImage,
        tabSettingsTitle: String,
        tabSettingsImage: UIImage
    ) {
        self.tabRandomJokesTitle = tabRandomJokesTitle
        self.tabRandomJokesImage = tabRandomJokesImage
        self.tabMyJokesTitle = tabMyJokesTitle
        self.tabMyJokesImage = tabMyJokesImage
        self.tabSettingsTitle = tabSettingsTitle
        self.tabSettingsImage = tabSettingsImage
    }
}

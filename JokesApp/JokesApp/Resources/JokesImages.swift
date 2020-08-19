import UIKit

struct JokesImages {
    
    static let feed: UIImage = .load("feed")
    static let favorites: UIImage = .load("favorites")
    static let settings: UIImage = .load("settings")
    static let add: UIImage = .load("add")
    
}

private extension UIImage {
    
    static func load(_ name: String) -> UIImage {
        guard let image = UIImage(named: name) else {
            fatalError("The Image with the name `\(name)` is missing")
        }
        return image
    }
}

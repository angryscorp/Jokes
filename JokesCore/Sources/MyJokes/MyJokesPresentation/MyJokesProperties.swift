import UIKit

public struct MyJokesProperties {
    
    let title: String
    let addButtonImage: UIImage
    let deleteButtonTitle: String
    
    public init(
        title: String,
        addButtonImage: UIImage,
        deleteButtonTitle: String
    ) {
        self.title = title
        self.addButtonImage = addButtonImage
        self.deleteButtonTitle = deleteButtonTitle
    }
}

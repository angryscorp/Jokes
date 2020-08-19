import Foundation

public struct MyJoke: Codable {
    
    public let id: ID
    public let text: String
    
    public init(_ text: String) {
        self.id = ID()
        self.text = text
    }
}

public extension MyJoke {
    
    typealias ID = UUID
}

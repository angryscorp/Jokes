import Foundation

extension URL: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StaticString) {
        guard let url = URL(string: value.description) else {
            fatalError("Unexpected error on converting String to URL")
        }
        self = url
    }
}

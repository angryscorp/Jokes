import UIKit

public extension NSLayoutConstraint {
    
    enum Edge: CaseIterable {
        case top
        case left
        case bottom
        case right
    }
    
    enum Dimension {
        case width
        case height
    }
}

public extension NSLayoutConstraint.Edge {
    
    var asAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top:
            return .top
        case .left:
            return .left
        case .right:
            return .right
        case .bottom:
            return .bottom
        }
    }
}

public extension NSLayoutConstraint.Dimension {
    
    var asAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .height:
            return .height
        case .width:
            return .width
        }
    }
}

public extension Array where Element == NSLayoutConstraint.Edge {
    
    static var all: [NSLayoutConstraint.Edge] {
        NSLayoutConstraint.Edge.allCases
    }
    
    static func all(except edge: NSLayoutConstraint.Edge) -> [NSLayoutConstraint.Edge] {
        all.filter { $0 != edge }
    }
}

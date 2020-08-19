import UIKit

public extension UIView {
    
    @discardableResult
    func constraint(
        _ edges: [NSLayoutConstraint.Edge],
        to item: Constrainable,
        constant: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        edges.map { constraint($0, to: item, constant: constant.adapt(for: $0)) }
    }
    
    @discardableResult
    func constraint(
        _ edge: NSLayoutConstraint.Edge,
        to item: Constrainable,
        edge other: NSLayoutConstraint.Edge? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let layoutConstraint = NSLayoutConstraint(
            item: self,
            attribute: edge.asAttribute,
            relatedBy: .equal,
            toItem: item,
            attribute: (other ?? edge).asAttribute,
            multiplier: multiplier,
            constant: constant
        )
        layoutConstraint.isActive = true
        return layoutConstraint
    }
    
    @discardableResult
    func constraint(
        _ dimension: NSLayoutConstraint.Dimension,
        to item: Constrainable? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let layoutConstraint = NSLayoutConstraint(
            item: self,
            attribute: dimension.asAttribute,
            relatedBy: .equal,
            toItem: item,
            attribute: item == nil ? .notAnAttribute : dimension.asAttribute,
            multiplier: multiplier,
            constant: constant
        )
        layoutConstraint.isActive = true
        return layoutConstraint
    }
    
    @discardableResult
    func constraint(size: CGSize) -> [NSLayoutConstraint] {
        [
            constraint(.width, constant: size.width),
            constraint(.height, constant: size.height)
        ]
    }
}

private extension CGFloat {
    
    func adapt(for edge: NSLayoutConstraint.Edge) -> CGFloat {
        switch edge {
        case .top, .left:
            return self
        case .right, .bottom:
            return -self
        }
    }
}

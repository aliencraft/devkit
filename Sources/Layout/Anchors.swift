import UIKit

public struct HorizontalAnchors {
    let item: LayoutItem
    let leading: NSLayoutXAxisAnchor
    let trailing: NSLayoutXAxisAnchor
}

public struct VerticalAnchors {
    let item: LayoutItem
    let top: NSLayoutYAxisAnchor
    let bottom: NSLayoutYAxisAnchor
}

public struct CenterAnchors {
    let item: LayoutItem
    let centerX: NSLayoutXAxisAnchor
    let centerY: NSLayoutYAxisAnchor
}

public struct SizeAnchors {
    let item: LayoutItem
    let width: NSLayoutDimension
    let height: NSLayoutDimension
}

public struct EdgeAnchors {
    let item: LayoutItem
    let top: NSLayoutYAxisAnchor
    let leading: NSLayoutXAxisAnchor
    let trailing: NSLayoutXAxisAnchor
    let bottom: NSLayoutYAxisAnchor
}

public protocol LayoutItem { // UIView, UILayoutGuide
    var superview: UIView? { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

extension LayoutItem {
    public var horizontalAnchors: HorizontalAnchors {
        HorizontalAnchors(item: self, leading: leadingAnchor, trailing: trailingAnchor)
    }

    public var verticalAnchors: VerticalAnchors {
        VerticalAnchors(item: self, top: topAnchor, bottom: bottomAnchor)
    }

    public var centerAnchors: CenterAnchors {
        CenterAnchors(item: self, centerX: centerXAnchor, centerY: centerYAnchor)
    }

    public var sizeAnchors: SizeAnchors {
        SizeAnchors(item: self, width: widthAnchor, height: heightAnchor)
    }

    public var edgeAnchors: EdgeAnchors {
        EdgeAnchors(item: self, top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
}

extension UIView: LayoutItem {}

extension UILayoutGuide: LayoutItem {
    public var superview: UIView? { owningView }
}

extension NSLayoutXAxisAnchor {
    @discardableResult
    public func equal(_ anchor: NSLayoutXAxisAnchor, offset: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        Constraints.add(constraint(equalTo: anchor, constant: offset).multiplied(by: multiplier))
    }

    @discardableResult
    public func greaterThanOrEqual(_ anchor: NSLayoutXAxisAnchor, offset: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        Constraints.add(constraint(greaterThanOrEqualTo: anchor, constant: offset).multiplied(by: multiplier))
    }

    @discardableResult
    public func lessThanOrEqual(_ anchor: NSLayoutXAxisAnchor, offset: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        Constraints.add(constraint(lessThanOrEqualTo: anchor, constant: offset).multiplied(by: multiplier))
    }
}

extension NSLayoutYAxisAnchor {
    @discardableResult
    public func equal(_ anchor: NSLayoutYAxisAnchor, offset: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        Constraints.add(constraint(equalTo: anchor, constant: offset).multiplied(by: multiplier))
    }

    @discardableResult
    public func greaterThanOrEqual(_ anchor: NSLayoutYAxisAnchor, offset: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        Constraints.add(constraint(greaterThanOrEqualTo: anchor, constant: offset).multiplied(by: multiplier))
    }

    @discardableResult
    public func lessThanOrEqual(_ anchor: NSLayoutYAxisAnchor, offset: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        Constraints.add(constraint(lessThanOrEqualTo: anchor, constant: offset).multiplied(by: multiplier))
    }
}

extension NSLayoutDimension {
    @discardableResult
    public func equal(_ constant: CGFloat) -> NSLayoutConstraint {
        Constraints.add(constraint(equalToConstant: constant))
    }

    @discardableResult
    public func equal(_ anchor: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        Constraints.add(constraint(equalTo: anchor, constant: constant).multiplied(by: multiplier))
    }

    @discardableResult
    public func greaterThanOrEqual(_ constant: CGFloat) -> NSLayoutConstraint {
        Constraints.add(constraint(greaterThanOrEqualToConstant: constant))
    }

    @discardableResult
    public func greaterThanOrEqual(_ anchor: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        Constraints.add(constraint(greaterThanOrEqualTo: anchor, constant: constant).multiplied(by: multiplier))
    }

    @discardableResult
    public func lessThanOrEqual(_ constant: CGFloat) -> NSLayoutConstraint {
        Constraints.add(constraint(lessThanOrEqualToConstant: constant))
    }

    @discardableResult
    public func lessThanOrEqual(_ anchor: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        Constraints.add(constraint(lessThanOrEqualTo: anchor, constant: constant).multiplied(by: multiplier))
    }
}

extension HorizontalAnchors {
    @discardableResult
    public func equal(_ anchors: HorizontalAnchors, insets: CGFloat = 0) -> [NSLayoutConstraint] {
        Constraints.add(
            leading.constraint(equalTo: anchors.leading, constant: insets),
            trailing.constraint(equalTo: anchors.trailing, constant: -insets)
        )
    }
    
    @discardableResult
    public func pin(to item: LayoutItem? = nil, insets: CGFloat = 0) -> [NSLayoutConstraint] {
        equal((item ?? self.item.superview!).horizontalAnchors, insets: insets)
    }
}

extension VerticalAnchors {
    @discardableResult
    public func equal(_ anchors: VerticalAnchors, insets: CGFloat = 0) -> [NSLayoutConstraint] {
        Constraints.add(
            top.constraint(equalTo: anchors.top, constant: insets),
            bottom.constraint(equalTo: anchors.bottom, constant: -insets)
        )
    }

    @discardableResult
    public func pin(to item: LayoutItem? = nil, insets: CGFloat = 0) -> [NSLayoutConstraint] {
        equal((item ?? self.item.superview!).verticalAnchors, insets: insets)
    }
}

extension CenterAnchors {
    @discardableResult
    public func equal(_ anchors: CenterAnchors, offset: CGPoint = .zero) -> [NSLayoutConstraint] {
        Constraints.add(
            centerX.constraint(equalTo: anchors.centerX, constant: offset.x),
            centerY.constraint(equalTo: anchors.centerY, constant: offset.y)
        )
    }

    @discardableResult
    public func pin(to item: LayoutItem? = nil, offset: CGPoint = .zero) -> [NSLayoutConstraint] {
        equal((item ?? self.item.superview!).centerAnchors, offset: offset)
    }
}

extension SizeAnchors {
    @discardableResult
    public func equal(_ anchors: SizeAnchors) -> [NSLayoutConstraint] {
        Constraints.add(
            width.constraint(equalTo: anchors.width),
            height.constraint(equalTo: anchors.height)
        )
    }

    @discardableResult
    public func equal(_ size: CGSize) -> [NSLayoutConstraint] {
        Constraints.add(
            width.constraint(equalToConstant: size.width),
            height.constraint(equalToConstant: size.height)
        )
    }

    @discardableResult
    public func greaterThanOrEqual(_ anchors: SizeAnchors) -> [NSLayoutConstraint] {
        Constraints.add(
            width.constraint(greaterThanOrEqualTo: anchors.width),
            height.constraint(greaterThanOrEqualTo: anchors.height)
        )
    }

    @discardableResult
    public func greaterThanOrEqual(_ size: CGSize) -> [NSLayoutConstraint] {
        Constraints.add(
            width.constraint(greaterThanOrEqualToConstant: size.width),
            height.constraint(greaterThanOrEqualToConstant: size.height)
        )
    }

    @discardableResult
    public func lessThanOrEqual(_ anchors: SizeAnchors) -> [NSLayoutConstraint] {
        Constraints.add(
            width.constraint(lessThanOrEqualTo: anchors.width),
            height.constraint(lessThanOrEqualTo: anchors.height)
        )
    }

    @discardableResult
    public func lessThanOrEqual(_ size: CGSize) -> [NSLayoutConstraint] {
        Constraints.add(
            width.constraint(lessThanOrEqualToConstant: size.width),
            height.constraint(lessThanOrEqualToConstant: size.height)
        )
    }

    @discardableResult
    public func pin(to item: LayoutItem? = nil) -> [NSLayoutConstraint] {
        equal((item ?? self.item.superview!).sizeAnchors)
    }
}

extension EdgeAnchors {
    @discardableResult
    public func equal(_ anchors: EdgeAnchors, insets: CGFloat = 0) -> [NSLayoutConstraint] {
        equal(anchors, insets: .all(insets))
    }

    @discardableResult
    public func equal(_ anchors: EdgeAnchors, insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
        return Constraints.add(
            top.constraint(equalTo: anchors.top, constant: insets.top),
            leading.constraint(equalTo: anchors.leading, constant: insets.leading),
            trailing.constraint(equalTo: anchors.trailing, constant: -insets.trailing),
            bottom.constraint(equalTo: anchors.bottom, constant: -insets.bottom)
        )
    }

    @discardableResult
    public func pin(to item: LayoutItem? = nil, insets: CGFloat = 0) -> [NSLayoutConstraint] {
        pin(to: item, insets: .all(insets))
    }

    @discardableResult
    public func pin(to item: LayoutItem? = nil, insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
        equal((item ?? self.item.superview!).edgeAnchors, insets: insets)
    }
}

extension NSLayoutConstraint {
    @discardableResult
    public func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
    fileprivate func multiplied(by multiplier: CGFloat) -> NSLayoutConstraint {
        guard multiplier != self.multiplier else { return self }
        return NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }
}

public final class Constraints {
    private static var stack: [Constraints] = []

    public private(set) var constraints: [NSLayoutConstraint] = []

    @discardableResult
    public init(activate: Bool = true, _ closure: () -> Void) {
        Constraints.stack.append(self)
        closure()
        Constraints.stack.removeLast()
        if activate {
            NSLayoutConstraint.activate(constraints)
        }
    }

    public func activate() {
        NSLayoutConstraint.activate(constraints)
    }

    public func deactivate() {
        NSLayoutConstraint.deactivate(constraints)
    }

    static func add(_ constraint: NSLayoutConstraint) -> NSLayoutConstraint {
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        if let group = stack.last {
            group.constraints.append(constraint)
        } else {
            constraint.isActive = true
        }
        return constraint
    }

    static func add(_ constraints: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        constraints.map(Constraints.add)
    }
}

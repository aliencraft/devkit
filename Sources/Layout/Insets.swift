import UIKit

extension NSDirectionalEdgeInsets {
    public static func all(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    public static func horizontal(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 0, leading: value, bottom: 0, trailing: value)
    }

    public static func vertical(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: value, leading: 0, bottom: value, trailing: 0)
    }

    public static func top(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: value, leading: 0, bottom: 0, trailing: 0)
    }

    public static func leading(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 0, leading: value, bottom: 0, trailing: 0)
    }

    public static func bottom(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: value, trailing: 0)
    }

    public static func trailing(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: value)
    }

    public init(horizontal: CGFloat, vertical: CGFloat) {
        self = NSDirectionalEdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}

extension UIEdgeInsets {
    public static func all(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }

    public static func horizontal(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: value, bottom: 0, right: value)
    }

    public static func vertical(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: value, left: 0, bottom: value, right: 0)
    }

    public static func top(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: value, left: 0, bottom: 0, right: 0)
    }

    public static func left(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: value, bottom: 0, right: 0)
    }

    public static func bottom(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
    }

    public static func right(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: value)
    }

    public init(horizontal: CGFloat, vertical: CGFloat) {
        self = UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

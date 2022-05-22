import UIKit

extension UIStackView {
    public convenience init(
        axis: NSLayoutConstraint.Axis = .horizontal,
        alignment: Alignment = .fill,
        distribution: Distribution = .fill,
        spacing: CGFloat = 0,
        margins: NSDirectionalEdgeInsets? = nil,
        @SubviewsBuilder subviews: () -> [UIView]
    ) {
        self.init(arrangedSubviews: subviews())
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        if let margins = margins {
            self.isLayoutMarginsRelativeArrangement = true
            self.directionalLayoutMargins = margins
        }
    }
}

@resultBuilder
public enum SubviewsBuilder {
    public static func buildBlock() -> [UIView] { [] }
    public static func buildBlock(_ components: UIView...) -> [UIView] { components }
    public static func buildBlock(_ components: [UIView]...) -> [UIView] { components.flatMap { $0 } }
    public static func buildOptional(_ component: [UIView]?) -> [UIView] { component ?? [] }
    public static func buildEither(first component: [UIView]) -> [UIView] { component }
    public static func buildEither(second component: [UIView]) -> [UIView] { component }
    public static func buildExpression(_ expression: UIView) -> [UIView] { [expression] }
    public static func buildExpression(_ expression: [UIView]) -> [UIView] { expression }
    public static func buildArray(_ components: [[UIView]]) -> [UIView] { components.flatMap { $0 } }
}

public final class FixedSpace: StackViewSpace {
    public init(_ length: CGFloat) {
        super.init(length: length, isFlexible: false)
    }
}

public final class FlexibleSpace: StackViewSpace {
    public init(_ minLength: CGFloat = 0) {
        super.init(length: minLength, isFlexible: true)
    }
}

public class StackViewSpace: UIView {
    private let length: CGFloat
    private let isFlexible: Bool
    private var axis: NSLayoutConstraint.Axis?
    private var axisObservation: NSKeyValueObservation?
    private var lengthConstraint: NSLayoutConstraint?

    fileprivate init(length: CGFloat, isFlexible: Bool) {
        self.length = length
        self.isFlexible = isFlexible
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let stackView = newSuperview as? UIStackView {
            axisObservation = stackView.observe(\.axis, options: [.initial]) { [unowned self] stackView, _ in
                axis = stackView.axis
                setNeedsUpdateConstraints()
            }
        } else {
            axisObservation = nil
            axis = nil
            setNeedsUpdateConstraints()
        }
    }

    public override func updateConstraints() {
        if let lengthConstraint = lengthConstraint {
            removeConstraint(lengthConstraint)
        }
        if let axis = axis {
            let constraint = NSLayoutConstraint(
                item: self,
                attribute: axis == .vertical ? .height : .width,
                relatedBy: isFlexible ? .greaterThanOrEqual : .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: length
            )
            constraint.priority = .required - 1
            constraint.isActive = true
            lengthConstraint = constraint
        } else {
            lengthConstraint = nil
        }
        super.updateConstraints()
    }
}

//import SwiftUI
//
//struct StackViews_Preview: PreviewProvider {
//    static var previews: some View {
//        UIStackView(axis: .vertical) {
//            UILabel()
//            FixedSpace(50)
//            UIStackView(axis: .horizontal) {
//                for _ in 1...3 {
//                    UILabel()
//                }
//                FixedSpace(20)
//                UILabel()
//            }
//        }
//        .preview
//    }
//}

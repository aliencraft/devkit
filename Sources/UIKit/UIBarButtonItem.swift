import UIKit

extension UIBarButtonItem {
    public convenience init(_ title: String, style: Style = .plain, action: @escaping () -> Void) {
        self.init(title: title, primaryAction: UIAction { _ in action() })
        self.style = style
    }
}

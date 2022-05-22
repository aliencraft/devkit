import SwiftUI

public struct ViewControllerRepresentable: UIViewControllerRepresentable {
    private let viewController: () -> UIViewController

    public init(_ viewController: @escaping () -> UIViewController) {
        self.viewController = viewController
    }

    public init(_ viewController: @escaping @autoclosure () -> UIViewController) {
        self.viewController = viewController
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        viewController()
    }

    public func updateUIViewController(_ viewController: UIViewController, context: Context) {}
}

extension UIViewController {
    public var preview: some View {
        ViewControllerRepresentable(self)
    }
}

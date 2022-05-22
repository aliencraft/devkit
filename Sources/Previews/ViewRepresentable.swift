import SwiftUI

public struct ViewRepresentable: UIViewRepresentable {
    private let view: () -> UIView

    public init(_ view: @escaping () -> UIView) {
        self.view = view
    }

    public init(_ view: @escaping @autoclosure () -> UIView) {
        self.view = view
    }

    public func makeUIView(context: Context) -> UIView {
        view()
    }

    public func updateUIView(_ view: UIView, context: Context) {}
}

extension UIView {
    public var preview: some View {
        ViewRepresentable(self)
    }
}

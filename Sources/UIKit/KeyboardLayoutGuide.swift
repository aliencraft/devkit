import UIKit

final class KeyboardLayoutGuide: UILayoutGuide {
    let ignoreSafeArea: Bool

    override var owningView: UIView? {
        didSet {
            addConstraints()
        }
    }

    private var topConstraint: NSLayoutConstraint?

    init(ignoreSafeArea: Bool) {
        self.ignoreSafeArea = ignoreSafeArea
        super.init()
        observeKeyboardNotifications()
    }

    required init?(coder: NSCoder) { nil }

    private func addConstraints() {
        guard let view = owningView else { return }

        let topConstraint: NSLayoutConstraint
        if ignoreSafeArea {
            topConstraint = topAnchor.constraint(equalTo: view.bottomAnchor)
            NSLayoutConstraint.activate([
                topConstraint,
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            topConstraint = topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            NSLayoutConstraint.activate([
                topConstraint,
                leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }

        self.topConstraint = topConstraint
    }

    private func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        var keyboardHeight = notification.keyboardHeight

        if !ignoreSafeArea {
            keyboardHeight -= owningView?.safeAreaInsets.bottom ?? 0
        }

        UIView.animate(
            withDuration: notification.keyboardAnimationDuration,
            delay: 0,
            options: notification.keyboardAnimationOptions,
            animations: { self.updateTopConstraint(for: keyboardHeight) }
        )
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(
            withDuration: notification.keyboardAnimationDuration,
            delay: 0,
            options: notification.keyboardAnimationOptions,
            animations: { self.updateTopConstraint(for: 0) }
        )
    }

    private func updateTopConstraint(for keyboardHeight: CGFloat) {
        topConstraint?.constant = -keyboardHeight
        owningView?.layoutIfNeeded()
        owningView?.superview?.layoutIfNeeded()
    }
}

private extension Notification {
    var keyboardAnimationDuration: TimeInterval {
        (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval) ?? 0.3
    }

    var keyboardAnimationOptions: UIView.AnimationOptions {
        if let animationCurve = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            return UIView.AnimationOptions(rawValue: animationCurve << 16)
        } else {
            return .curveEaseInOut
        }
    }

    var keyboardHeight: CGFloat {
        (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
    }
}

public extension UIView {
    var noSafeAreaKeyboardLayoutGuide: UILayoutGuide {
        findKeyboardLayoutGuide(ignoreSafeArea: true) ?? makeKeyboardLayoutGuide(ignoreSafeArea: true)
    }

    var safeAreaKeyboardLayoutGuide: UILayoutGuide {
        findKeyboardLayoutGuide(ignoreSafeArea: false) ?? makeKeyboardLayoutGuide(ignoreSafeArea: false)
    }

    private func findKeyboardLayoutGuide(ignoreSafeArea: Bool) -> UILayoutGuide? {
        layoutGuides.first { guide in
            guard let guide = guide as? KeyboardLayoutGuide else { return false }
            return guide.ignoreSafeArea == ignoreSafeArea
        }
    }

    private func makeKeyboardLayoutGuide(ignoreSafeArea: Bool) -> UILayoutGuide {
        let guide = KeyboardLayoutGuide(ignoreSafeArea: ignoreSafeArea)
        addLayoutGuide(guide)
        return guide
    }
}

import UIKit

extension UIViewController {
    public func embed(_ child: UIViewController) {
        if let current = children.last {
            current.willMove(toParent: nil)
            addChild(child)
            view.addSubview(child.view)
            child.view.edgeAnchors.pin()
            child.view.layoutIfNeeded()
            UIView.transition(
                from: current.view,
                to: child.view,
                duration: 0.3,
                options: [.transitionCrossDissolve, .curveEaseInOut],
                completion: { finished in
                    current.removeFromParent()
                    current.view.removeFromSuperview()
                    child.didMove(toParent: self)
                }
            )
        } else {
            addChild(child)
            view.addSubview(child.view)
            child.view.edgeAnchors.pin()
            child.didMove(toParent: self)
        }
    }

    public func embeddedInNavigationController(preferLargeTitles: Bool = true) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.prefersLargeTitles = preferLargeTitles
        return navigationController
    }
}

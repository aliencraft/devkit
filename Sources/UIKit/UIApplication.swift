import UIKit

extension UIApplication{
    public var topViewController: UIViewController? {
        guard var topViewController = keyWindow?.rootViewController else { return nil }
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }

    public var keyWindow: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
        return scene.windows.first(where: \.isKeyWindow)
    }
}

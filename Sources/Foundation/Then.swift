import Foundation

public protocol Then {}

extension Then where Self: AnyObject {
    public func then(_ closure: (Self) throws -> Void) rethrows -> Self {
        try closure(self)
        return self
    }
}

extension NSObject: Then {}

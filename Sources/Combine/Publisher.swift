import Combine

extension Publisher {
    public func ignoreFailure() -> AnyPublisher<Output, Never> {
        self.catch { _ in Empty() }
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
    }
}

// See https://forums.swift.org/t/does-assign-to-produce-memory-leaks/29546
extension Publisher where Failure == Never {
    public func assign<Root: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<Root, Output>,
        onWeak root: Root
    ) -> AnyCancellable {
        sink { [weak root] in root?[keyPath: keyPath] = $0 }
    }
}

/// Break Combine reference cycles:
/// Combine’s assign(to:on:) captures the on parameter strongly, potentially creating reference cycles.
/// Likewise, I’m forced to do the [weak self] dance in Combine’s sink(receiveValue:) to avoid cycles.
/// weakAssign and weakSink to the rescue:

//extension Publisher where Failure == Never {
//    func weakAssign<T: AnyObject>(
//        to keyPath: ReferenceWritableKeyPath<T, Output>,
//        on object: T
//    ) -> AnyCancellable {
//        sink { [weak object] value in
//            object?[keyPath: keyPath] = value
//        }
//    }
//
//    func weakSink<T: AnyObject>(
//        _ weaklyCaptured: T,
//        receiveValue: @escaping (T, Self.Output) -> Void
//    ) -> AnyCancellable {
//        sink { [weak weaklyCaptured] output in
//            guard let strongRef = weaklyCaptured else { return }
//            receiveValue(strongRef, output)
//        }
//    }
//}

import UIKit

extension UICollectionView {
    public func clearSelection(animated: Bool = true) {
        guard let selection = indexPathsForSelectedItems else { return }
        for indexPath in selection {
            deselectItem(at: indexPath, animated: animated)
        }
    }
}

extension UICollectionView.CellRegistration {
    public var cellProvider: (UICollectionView, IndexPath, Item) -> Cell {
        { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: self, for: indexPath, item: item)
        }
    }
}

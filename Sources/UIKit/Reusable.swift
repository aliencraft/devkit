import UIKit

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}
extension UICollectionReusableView: Reusable {}

extension UITableView {
    public func register<Cell: UITableViewCell>(_: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    public func dequeue<Cell: UITableViewCell>(_: Cell.Type, for indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }

    public func register<View: UITableViewHeaderFooterView>(_: View.Type) {
        register(View.self, forHeaderFooterViewReuseIdentifier: View.reuseIdentifier)
    }

    public func dequeue<View: UITableViewHeaderFooterView>(_: View.Type) -> View {
        dequeueReusableHeaderFooterView(withIdentifier: View.reuseIdentifier) as! View
    }
}

extension UICollectionView {
    public func register<Cell: UICollectionViewCell>(_: Cell.Type) {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }

    public func dequeue<Cell: UICollectionViewCell>(_: Cell.Type, for indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }

    public func dequeue<Cell: UICollectionViewCell>(
        _: Cell.Type,
        for indexPath: IndexPath,
        configure: (Cell) -> Void
    ) -> Cell {
        let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        configure(cell)
        return cell
    }

    public func register<View: UICollectionReusableView>(_: View.Type) {
        register(
            View.self,
            forSupplementaryViewOfKind: View.reuseIdentifier,
            withReuseIdentifier: View.reuseIdentifier
        )
    }

    public func dequeue<View: UICollectionReusableView>(_: View.Type, for indexPath: IndexPath) -> View {
        dequeueReusableSupplementaryView(
            ofKind: View.reuseIdentifier,
            withReuseIdentifier: View.reuseIdentifier,
            for: indexPath
        ) as! View
    }
}

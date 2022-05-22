import UIKit

public final class ContainerCell: UICollectionViewListCell {
    public var content: UIView? {
        didSet {
            if let content = content {
                contentView.addSubview(content)
                content.edgeAnchors.pin()
                content.preservesSuperviewLayoutMargins = true
            }
        }
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        content?.removeFromSuperview()
    }

    // disables cell highlighting
    public override func updateConfiguration(using state: UICellConfigurationState) {
        automaticallyUpdatesBackgroundConfiguration = false
        var modifiedState = state
        modifiedState.isHighlighted = false
        modifiedState.isSelected = false
        backgroundConfiguration = backgroundConfiguration?.updated(for: modifiedState)
    }
}

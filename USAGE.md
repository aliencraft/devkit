# Layout

### Stacks

```swift
UIStackView(axis: .horizontal, alignment: .center) {
    imageView
    UIStackView(axis: .vertical, alignment: .leading) {
        titleLabel
        subtitleLabel
    }
}
```

### Anchors

```swift
 // single anchors
 a.topAnchor.equal(b.bottomAnchor)
 a.topAnchor.greaterThanOrEqual(b.bottomAnchor)
 a.topAnchor.lessThanOrEqual(b.bottomAnchor)

 // offset and multiplier
 a.topAnchor.equal(b.bottomAnchor, offset: 16)
 a.widthAnchor.equal(a.heightAnchor, multiplier: 2)
 
 // constants
 a.heightAnchor.equal(44)
 
 // multiple anchors (center, size, horizontal, vertical, edge)
 a.centerAnchors.equal(b.center.anchors)
 a.sizeAnchors.equal(CGSize(width: 80, height: 44))

 // pin to superview
 a.edgeAnchors.pin()

 // pin to other view or layout guide
 a.edgeAnchors.pin(to: b)
 a.edgeAnchors.pin(to: b.safeAreaLayoutGuide)

 // insets and offsets
 a.edgeAnchors.pin(insets: 16)
 a.edgeAnchors.pin(insets: NSDirectionalEdgeInsets(...))
 a.centerAnchors.pin(offset: CGPoint(x: 0, y: 20))

 // set priority
 a.heightAnchor.equal(44).withPriority(.defaultHigh)

 // activate all constraints at the same time (more efficient)
 Constraints {
    ...
 }
 
 // create constraints without activation
 let c = Constraints(activate: false) {
    ...
 }
 c.activate()
 c.deactivate()
```

### Insets

```swift
// TODO
```

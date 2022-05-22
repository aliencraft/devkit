import SwiftUI
import UIKit

open class FormViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let stack = UIStackView(axis: .vertical, spacing: 16) {
            for _ in 0...4 {
                makeLabel()
            }
            FlexibleSpace()
        }
        
        view.addSubview(stack)
        let c = Constraints(activate: false) {
            stack.edgeAnchors.pin()
        }
        c.activate()
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.text = "Hello World"
        label.backgroundColor = .systemGreen
        label.heightAnchor.equal(44).withPriority(.defaultLow)
        return label
    }
}

struct FormViewController_Previews: PreviewProvider {
    static var previews: some View {
        FormViewController().preview
    }
}

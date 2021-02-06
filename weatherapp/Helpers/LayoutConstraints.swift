import UIKit

struct LayoutConstraints {
    static func construct(item view1: Any,
                          attribute attr1: NSLayoutConstraint.Attribute,
                          relatedBy relation: NSLayoutConstraint.Relation = .equal,
                          toItem view2: Any? = nil,
                          attribute attr2: NSLayoutConstraint.Attribute = .notAnAttribute,
                          multiplier m: CGFloat = 1,
                          constant c: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view1,
            attribute: attr1,
            relatedBy: relation,
            toItem: view2,
            attribute: attr2,
            multiplier: m,
            constant: c
        )
    }
}

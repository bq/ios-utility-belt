import UIKit

public class SnackBar: UIView {

    private let label: UILabel = UILabel()

    public var message: String? {
        return label.text
    }

    required init(_ message: String,
                  font: UIFont,
                  frame: CGRect) {
        super.init(frame: frame)
        setup(message, font: font)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(_ message: String, font: UIFont) {

        self.accessibilityIdentifier = "SnackBarID"
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)

        label.font = font
        label.text = message
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        var constraintsLabel = [NSLayoutConstraint]()
        constraintsLabel.append(NSLayoutConstraint(item: label,
                                                   attribute: NSLayoutConstraint.Attribute.leading,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   toItem: self,
                                                   attribute: NSLayoutConstraint.Attribute.leading,
                                                   multiplier: 1.0,
                                                   constant: 24))

        constraintsLabel.append(NSLayoutConstraint(item: self,
                                                   attribute: NSLayoutConstraint.Attribute.trailing,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   toItem: label,
                                                   attribute: NSLayoutConstraint.Attribute.trailing,
                                                   multiplier: 1.0,
                                                   constant: 24))

        constraintsLabel.append(NSLayoutConstraint(item: label,
                                                   attribute: NSLayoutConstraint.Attribute.top,
                                                   relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual,
                                                   toItem: self,
                                                   attribute: NSLayoutConstraint.Attribute.top,
                                                   multiplier: 1.0,
                                                   constant: 12))

        constraintsLabel.append(NSLayoutConstraint(item: self,
                                                   attribute: NSLayoutConstraint.Attribute.bottom,
                                                   relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual,
                                                   toItem: label,
                                                   attribute: NSLayoutConstraint.Attribute.bottom,
                                                   multiplier: 1.0,
                                                   constant: 12))

        constraintsLabel.append(NSLayoutConstraint(item: label,
                                                   attribute: NSLayoutConstraint.Attribute.centerY,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   toItem: self,
                                                   attribute: NSLayoutConstraint.Attribute.centerY,
                                                   multiplier: 1.0,
                                                   constant: 0))

        NSLayoutConstraint.activate(constraintsLabel)
    }

    @discardableResult
    static public func showMessage(_ message: String,
                                   font: UIFont = UIFont.systemRegular(size: 14),
                                   in view: UIView) -> SnackBar {

        let snackBar = SnackBar(message,
                                font: font,
                                frame: CGRect(x: 0,
                                              y: view.frame.height,
                                              width: view.frame.width,
                                              height: 80))
        view.addSubview(snackBar)
        UIView.animate(withDuration: 0.4, animations: {
            snackBar.frame.origin.y = view.frame.height - 80
            Timer.scheduledTimer(withTimeInterval: TimeInterval(2),
                                 repeats: false,
                                 block: { _ in
                                    UIView.animate(withDuration: 0.4, animations: {
                                        snackBar.frame.origin.y = view.frame.height
                                    })
            })
        })

        return snackBar
    }
}

import UIKit

public class Toast: UIView {

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
        self.accessibilityIdentifier = "ToastID"
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.alpha = 1.0
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.addSubview(label)

        label
            .topAnchor
            .constraint(equalTo: self.topAnchor,
                        constant: 0)
            .isActive = true

        label
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor,
                        constant: 0)
            .isActive = true

        label
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor,
                        constant: 0)
            .isActive = true

        label
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor,
                        constant: 0)
            .isActive = true

        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = message
        label.numberOfLines = 2
        label.font = font
    }

    @discardableResult
    static public func showMessage(_ message: String,
                                   font: UIFont = UIFont.systemRegular(size: 10),
                                   in view: UIView) -> Toast {

        let toastFrame = CGRect(x: view.frame.size.width / 2 - 75,
                                y: view.frame.size.height - 100,
                                width: 150, height: 70)

        let toast = Toast(message,
                          font: font,
                          frame: toastFrame)

        view.addSubview(toast)
        UIView.animate(withDuration: 3.0,
                       delay: 0.1,
                       options: .curveEaseOut,
                       animations: { toast.alpha = 0.0 },
                       completion: { _ in toast.removeFromSuperview() })
        return toast
    }
}

import Foundation

public extension UIStackView {

    // MARK: - Methods

    /// Adds views
    ///
    /// - Parameter views: views array.
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }

    /// Removes all arranged subviews
    func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}

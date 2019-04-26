import UIKit

public extension UIScrollView {

    // MARK: - Methods

    /// Scroll until view is visible
    ///
    /// - Parameters:
    ///   - view: view to show
    ///   - animated: with animation (default is true)
    func scrollToView(view: UIView, animated: Bool = true) {
        if let origin = view.superview {
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            self.scrollRectToVisible(CGRect(x: 0, y: childStartPoint.y, width: 1, height: self.frame.height), animated: animated)
        }
    }

    /// Scroll to top
    ///
    /// - Parameter animated: with animation (default is true)
    func scrollToTop(animated: Bool = true) {
        setContentOffset(.zero, animated: animated)
    }

    /// Scroll to bottom
    ///
    /// - Parameter animated: with animation (default is true)
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if bottomOffset.y > 0 {
            setContentOffset(bottomOffset, animated: animated)
        }
    }
}

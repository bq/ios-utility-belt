import UIKit

public extension UIViewController {

    /// Return to previus navigation screen
    ///
    /// - Parameter animated: with animation (default is true)
    func popView(animated: Bool = true) {
        _ = navigationController?.popViewController(animated: animated)
    }
}

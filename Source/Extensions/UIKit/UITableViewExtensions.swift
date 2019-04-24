import UIKit

public extension UITableView {

    /// Register UITableViewCell using class name.
    ///
    /// - Parameter type: UITableViewCell type.
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: type))
    }

    /// Register UITableViewCell with .xib file using only its corresponding class.
    ///     Assumes that the .xib filename and cell class has the same name.
    ///
    /// - Parameter type: UITableViewCell type.
    func registerWithNib<T: UITableViewCell>(_ type: T.Type, bundle: Bundle? = nil) {
        let identifier = String(describing: type)
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }

    /// Dequeue reusable UITableViewCell using class name.
    ///
    /// - Parameters:
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: T.self),
                                   for: indexPath) as? T
    }
}

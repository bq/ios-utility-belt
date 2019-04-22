import UIKit

public extension UICollectionView {

    /// Register UICollectionViewCell using class name.
    ///
    /// - Parameter type: UICollectionViewCell type.
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: type))
    }

    /// Register UICollectionReusableView using class name.
    ///
    /// - Parameters:
    ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
    ///   - name: UICollectionReusableView type.
    func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }

    /// Register UICollectionViewCell with .xib file using only its corresponding class.
    ///     Assumes that the .xib filename and cell class has the same name.
    ///
    /// - Parameter type: UICollectionViewCell type.
    func registerWithNib<T: UICollectionViewCell>(_ type: T.Type, bundle: Bundle? = nil) {
        let identifier = String(describing: type)
        register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }

    /// Dequeue reusable UICollectionViewCell using class name.
    ///
    /// - Parameters:
    ///   - indexPath: location of cell in collectionView.
    /// - Returns: UICollectionViewCell object with associated class name.
    func dequeueReusableCell<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                             for: indexPath) as? T else {
            fatalError("\(String(describing: T.self)) could not be dequeued for \(indexPath) as \(T.self)")
        }

        return cell
    }

    /// Dequeue reusable UICollectionReusableView using class name.
    ///
    /// - Parameters:
    ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
    ///   - indexPath: location of cell in collectionView.
    /// - Returns: UICollectionReusableView object with associated class name.
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(kind: String, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: String(describing: T.self),
                                                          for: indexPath) as? T else {
            fatalError("\(String(describing: T.self)) could not be dequeued for \(indexPath) of kind \(kind) as \(T.self)")
        }

        return cell
    }
}

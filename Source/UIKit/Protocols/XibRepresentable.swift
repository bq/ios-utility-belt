import Foundation

/// Used to link a View with his XIB that use the same name.
public protocol XibRepresentable: class {
    static var xibName: String { get }
}

public extension XibRepresentable {
    static var xibName: String {
        return String(describing: self)
    }
}

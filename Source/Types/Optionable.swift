import Foundation

/// Type erasure for optional
public protocol Optionable {
    associatedtype Wrapped
    var wrapped: Wrapped? { get }
}

extension Optional: Optionable {
    /// Return himselft value as a optional
    public var wrapped: Wrapped? {
        return self
    }
}

public extension Sequence where Iterator.Element: Optionable {
    /// Remove all the nullable values inside a nullable values array.
    ///
    /// - Returns: A Collection without null values.
    var filterNils: [Iterator.Element.Wrapped] {
        return self.compactMap { $0.wrapped }
    }
}

import Foundation

public extension Array where Element: Hashable {
    /// Return an array without repeat any hashable value
    var unique: [Element] {
        return Array(Set(self))
    }
}

public extension Array where Element: Equatable {
    /// Remove first collection element that is equal to the given `object`:
    @discardableResult
    mutating func remove(_ object: Element) -> Bool {
        if let index = index(of: object) {
            remove(at: index)
            return true
        }
        return false
    }

    /// Append the given element if not exists in array
    mutating func appendIfNotExists(_ element: Element) -> Bool {
        if !self.contains(element) {
            append(element)
            return true
        }
        return false
    }
}

import Foundation

public extension Array where Element: Hashable {
    /// Return an array without repeat any hashable value
    var unique: [Element] {
        return Array(Set(self))
    }

    /// Return false or true when array is empty or not
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

public extension Array where Element: Equatable {
    /// Remove first collection element that is equal to the given `object`:
    @discardableResult
    mutating func remove(_ object: Element) -> Bool {
        if let index = firstIndex(of: object) {
            remove(at: index)
            return true
        }
        return false
    }

    /// Append the given element if not exists in array
    @discardableResult
    mutating func appendIfNotExists(_ element: Element) -> Bool {
        if !self.contains(element) {
            append(element)
            return true
        }
        return false
    }
}

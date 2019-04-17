import Foundation

public extension Sequence {
    /// Group the sequence and return a dictionary using the given key in the closure.
    ///
    /// - Parameter key: Closure that generate the key of every element. The return value must be `Hashable`.
    /// - Returns: A dictionary with all elements grouped by the given key.
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U: [Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}

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
        if let index = firstIndex(of: object) {
            remove(at: index)
            return true
        }
        return false
    }

    /// Update existing elements or insert if not exists
    mutating func upsert(_ newElements: [Element]) {
        newElements.forEach { element in
            upsert(element)
        }
    }

    /// Update existing element or insert if not exists
    mutating func upsert(_ newElement: Element) {
        if let element = filter({ $0 == newElement }).first,
            let index = firstIndex(of: element) {
            remove(at: index)
            insert(newElement, at: index)
        } else {
            append(newElement)
        }
    }

    /// Update existing elements or insert if not exists
    func upserting(_ newElements: [Element]) -> [Element] {
        var result = self
        newElements.forEach { element in
            result = result.upserting(element)
        }
        return result
    }

    /// Update existing element or insert if not exists
    func upserting(_ newElement: Element) -> [Element] {
        var result = self
        if let element = result.first(where: { $0 == newElement }),
            let index = result.firstIndex(of: element) {
            result.remove(at: index)
            result.insert(newElement, at: index)
        } else {
            result.append(newElement)
        }
        return result
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

    /// Append the given element if not exists in array
    @discardableResult
    mutating func appendIfNotExists(_ elements: [Element]) -> Bool {
        var result = false
        elements.forEach { element in
            result = appendIfNotExists(element) || result
        }
        return result
    }

    /// Return a copy of the array by appending the given element if not exists in array
    func appendingIfNotExists(_ element: Element) -> [Element] {
        var result = self
        if !result.contains(element) {
            result.append(element)
        }
        return result
    }

    /// Return a copy of the array by appending the given elements if not exists in array
    func appendingIfNotExists(_ elements: [Element]) -> [Element] {
        var result = self
        elements.forEach { element in
            result = result.appendingIfNotExists(element)
        }
        return result
    }
}

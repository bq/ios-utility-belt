import Foundation

public extension String {
    init<T>(dumping object: T) {
        self.init()
        dump(object, to: &self)
    }
}

/// Compares 2 objects and iterates over their differences
///
/// - Parameters:
///   - lhs: expected object
///   - rhs: received object
///   - closure: iteration closure
public func diff<T>(_ expected: T, _ received: T, level: Int = 0, closure: (_ description: String) -> Void) {
    let lhsMirror = Mirror(reflecting: expected)
    let rhsMirror = Mirror(reflecting: received)

    guard !lhsMirror.children.isEmpty, !rhsMirror.children.isEmpty else {
        if String(dumping: received) != String(dumping: expected) {
            var expectedString = String()
            var receivedString = String()
            dump(expected, to: &expectedString)
            dump(received, to: &receivedString)
            closure("↪️ \(expectedString) ➡️ \(receivedString)\n")
        }
        return
    }

    switch (lhsMirror.displayStyle, rhsMirror.displayStyle) {
    case (.collection?, .collection?), (.dictionary?, .dictionary?):
        if lhsMirror.children.count != rhsMirror.children.count {
            var expectedString = String()
            var receivedString = String()
            dump(expected, to: &expectedString)
            dump(received, to: &receivedString)
            closure("""
                different count:
                ↪️ \(expectedString) (\(rhsMirror.children.count))
                ➡️ \(receivedString) (\(lhsMirror.children.count))\n
                """)
            return
        }
    case (.enum?, .enum?) where lhsMirror.children.first?.label != rhsMirror.children.first?.label,
         (.optional?, .optional?) where lhsMirror.children.count != rhsMirror.children.count:
        var expectedString = String()
        var receivedString = String()
        dump(expected, to: &expectedString)
        dump(received, to: &receivedString)
        closure("""
            different label:
            ↪️ \(expectedString)
            ➡️ \(receivedString)\n
            """)
    default:
        break
    }

    let zipped = zip(lhsMirror.children, rhsMirror.children)
    zipped.forEach { lhs, rhs in
        let leftDump = String(dumping: lhs.value)
        if leftDump != String(dumping: rhs.value) {
            if let notPrimitive = Mirror(reflecting: lhs.value).displayStyle, notPrimitive != .tuple {
                var results = [String]()
                diff(lhs.value, rhs.value, level: level + 1) { diff in
                    var diffString = String()
                    results.append(dump(diff, to: &diffString))
                }
                if !results.isEmpty {
                    if let label = lhs.label {
                        closure("different content (\(label)):\n" + results.joined())
                    } else {
                        closure("different content:\n" + results.joined())
                    }
                }
            } else {
                var expectedString = String()
                var receivedString = String()
                dump(lhs.value, to: &expectedString)
                dump(rhs.value, to: &receivedString)
                closure("\(lhs.label ?? "") ↪️ \(expectedString) ➡️ \(receivedString)\n".trimmingCharacters(in: CharacterSet.whitespaces))
            }
        }
    }
}

/// Builds list of differences between 2 objects
///
/// - Parameters:
///   - expected: Expected value
///   - received: Received value
/// - Returns: List of differences
public func diff<T>(_ expected: T, _ received: T) -> [String] {
    var all = [String]()
    diff(expected, received) { all.append($0) }
    return all
}

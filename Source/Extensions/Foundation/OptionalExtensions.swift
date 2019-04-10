import Foundation

public extension Optional {
    var isNil: Bool {
        return self == nil
    }
}

public extension Optional where Wrapped == Bool {
    /// returns true when the actual value is logically true.
    var isTruthy: Bool {
        if let value = self {
            return value
        }
        return false
    }

    /// returns true when the actual value is not logically true.
    var isFalsy: Bool {
        if let value = self {
            return value.isFalse
        }
        return false
    }
}

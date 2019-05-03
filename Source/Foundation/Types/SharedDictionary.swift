import Foundation

/// Wrapper class to allow pass dictionaries has a memory reference
public class SharedDictionary<Key: Hashable, Value> {
    public var innerDictionary: [Key: Value]

    public init() {
        innerDictionary = [:]
    }

    public func getOrPut(_ key: Key, defaultValue: () -> Value) -> Value {
        return self[key, orPut: defaultValue]
    }

    public func get(withKey key: Key) -> Value? {
        return self[key]
    }

    public subscript (_ key: Key, orPut defaultValue: () -> Value) -> Value {
        return innerDictionary.getOrPut(key, defaultValue: defaultValue)
    }

    public subscript (_ key: Key) -> Value? {
        return innerDictionary[key]
    }
}

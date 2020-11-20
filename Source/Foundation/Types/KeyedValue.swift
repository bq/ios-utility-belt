import Foundation

public protocol KeyedValueType {
    associatedtype Value

    var id: String { get }
    var value: Value { get }
}

public struct KeyedValue<Value: Codable>: KeyedValueType, Equatable, Codable {
    public let id: String
    public let value: Value

    public init(id: String, value: Value) {
        self.id = id
        self.value = value
    }

    // MARK: - Codable
    internal enum CodingKeys: String, CodingKey {
        case id
        case value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.value = try container.decode(Value.self, forKey: .value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(value, forKey: .value)
    }

    // MARK: - Equatable

    public static func == (lhs: KeyedValue<Value>, rhs: KeyedValue<Value>) -> Bool {
        return lhs.id == rhs.id
    }
}

import Foundation

public enum CurrencyCodeType: RawRepresentable, Equatable, Codable, CaseIterable {
    case euro
    case dollar
    case custom(String)

    // MARK: - RawRepresentable

    public init(rawValue: String) {
        switch rawValue {
        case CurrencyCodeType.euro.rawValue: self = .euro
        case CurrencyCodeType.dollar.rawValue: self = .dollar
        default: self = .custom(rawValue)
        }
    }

    public var rawValue: String {
        switch self {
        case .euro: return "EUR"
        case .dollar: return "USD"
        case .custom(let value): return value
        }
    }

    // MARK: - CaseIterable

    static public var allCases: [CurrencyCodeType] {
        return [.euro, .dollar]
    }

    // MARK: - Codable
    internal enum CodingKeys: String, CodingKey {
        case code
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let code = try container.decode(String.self, forKey: .code)
        self.init(rawValue: code)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rawValue, forKey: .code)
    }

    // MARK: - Equatable

    static public func == (lhs: CurrencyCodeType, rhs: CurrencyCodeType) -> Bool {
        switch (lhs, rhs) {
        case (.euro, .euro):
            return true
        case (.dollar, .dollar):
            return true
        case (.custom(let lhsCustom), .custom(let rhsCustom)):
            return lhsCustom == rhsCustom
        default:
            return false
        }
    }
}

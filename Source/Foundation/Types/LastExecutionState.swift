import Foundation

/// Enum that represent the status of the last attemp of a process or routine.
public enum LastExecutionState: Codable, Equatable {
    case never
    case failure
    case noData(Date)
    case dataUpdated(Date)

    // MARK: - Codable
    internal enum CodingKeys: String, CodingKey {
        case code = "executionCode"
        case date = "executionDate"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let code = try container.decode(Int.self, forKey: .code)
        let date = try? container.decode(Date.self, forKey: .date)

        switch (code, date) {
        case (0, .none):
            self = .never
        case (1, .none):
            self = .failure
        case (2, .some(let date)):
            self = .noData(date)
        case (3, .some(let date)):
            self = .dataUpdated(date)
        default:
            throw NSError(domain: "Invalid code: \(code)", code: 1, userInfo: nil)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(internalCode, forKey: .code)
        try container.encode(internalDate, forKey: .date)
    }

    // MARK: Private methods

    private var internalCode: Int {
        switch self {
        case .never: return 0
        case .failure: return 1
        case .noData: return 2
        case .dataUpdated: return 3
        }
    }

    private var internalDate: Date? {
        switch self {
        case .never: return nil
        case .failure: return nil
        case .noData(let date): return date
        case .dataUpdated(let date): return date
        }
    }
}

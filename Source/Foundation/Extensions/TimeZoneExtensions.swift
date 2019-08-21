import Foundation

public extension TimeZone {
    static var utc: TimeZone { return TimeZone(abbreviation: "UTC")! }
    static var madrid: TimeZone { return TimeZone(identifier: "Europe/Madrid")! }
}

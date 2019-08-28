import Foundation

public extension TimeZone {
    static var utc: TimeZone { return TimeZone(abbreviation: "UTC")! }
    static var europeMadrid: TimeZone { return TimeZone(identifier: "Europe/Madrid")! }
}

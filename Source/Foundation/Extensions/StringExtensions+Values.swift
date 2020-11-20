import Foundation

public extension String {
    var boolValue: Bool? {
        switch self.lowercased() {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }

    var urlValue: URL? {
        return URL(string: self)
    }

    /// Convert String to Date with Date Format (if don't specify it, will look for all Date Formats contemplated)
    ///
    /// - Parameters:
    ///   - dateFormat: Format Date to convert
    ///   - locale: Language rules for date
    ///   - timeZone: Time zone to format date
    /// - Returns: Date with specified or resolved format
    func date(dateFormat: Date.Format? = nil,
              locale: Locale = .posix,
              timeZone: TimeZone = .utc) -> Date? {

        return Date(formattedDate: self,
                    dateFormat: dateFormat,
                    locale: locale,
                    timeZone: timeZone)
    }
}

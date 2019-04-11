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

    func dateValue(timeZone: TimeZone? = nil) -> Date? {
        let defaultDateFormatter = DateFormatter.plainDateFormatter
        let yearDateFormatter = DateFormatter.yearDateFormatter

        if let timeZone = timeZone {
            defaultDateFormatter.timeZone = timeZone
            yearDateFormatter.timeZone = timeZone
        }

        let ISO8601Formatter = DateFormatter.iso8601DateFormatter

        if let dateFormatted = defaultDateFormatter.date(from: self) {
            return dateFormatted
        } else if let dateFormatted = yearDateFormatter.date(from: self) {
            return dateFormatted
        } else if let dateFormatted = ISO8601Formatter.date(from: self) {
            return dateFormatted
        }

        return nil
    }
}

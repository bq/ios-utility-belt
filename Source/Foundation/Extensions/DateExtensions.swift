import Foundation

public extension Date {
    init(millisecondsSince1970: Double) {
        self = Date(timeIntervalSince1970: millisecondsSince1970 / 1_000)
    }

    init?(formattedSpanishFullDate: String, timeZone: TimeZone? = nil) {
        let formatter = DateFormatter.spanishDateFormatter
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        guard let date = formatter.date(from: formattedSpanishFullDate) else {
            return nil
        }
        self = date
    }

    init?(rfc822Date: String) {
        guard let date = DateFormatter.rfc822DateFormatter.date(from: rfc822Date) else {
            return nil
        }
        self = date
    }

    var millisecondsSince1970: Double {
        return timeIntervalSince1970 * 1_000.0
    }

    var day: String {
        return formatWith(dateFormat: "d")
    }

    var monthSpanishNameAndYear: String {
        return formatWith(dateFormat: "MMMM yyyy")
    }

    var monthSpanishName: String {
        return formatWith(dateFormat: "MMMM")
    }

    var shortMonthSpanishName: String {
        return formatWith(dateFormat: "MMM")
    }

    var year: String {
        return formatWith(dateFormat: "yyyy")
    }

    var shortYear: String {
        return formatWith(dateFormat: "yy")
    }

    func formattedSpanishDate(timeZone: TimeZone? = nil) -> String {
        return formatWith(dateFormat: "dd 'de' MMMM", timeZone: timeZone)
    }

    func formattedSpanishFullDate(timeZone: TimeZone? = nil) -> String {
        return formatWith(dateFormat: "dd/MM/yyyy HH:mm", timeZone: timeZone)
    }

    func formattedTime(timeZone: TimeZone? = nil) -> String {
        return formatWith(dateFormat: "HH:mm", timeZone: timeZone)
    }

    var formattedRFC822Date: String {
        return DateFormatter.rfc822DateFormatter.string(from: self)
    }

    var isInTheFirstElevenDaysOfTheMonth: Bool {
        let day = Calendar.current.component(.day, from: self)
        return 1...11 ~= day
    }

    var isToday: Bool {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.isDateInToday(self)
    }

    // MARK: - Private methods

    private func formatWith(dateFormat: String, timeZone: TimeZone? = nil) -> String {
        let formatter = DateFormatter.spanishDateFormatter
        formatter.dateFormat = dateFormat
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        return formatter.string(from: self)
    }
}

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

    init?(iso8601Date: String) {
        guard let date = DateFormatter.iso8601DateFormatter.date(from: iso8601Date) else {
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

    var formattedDay: String {
        return format(dateFormat: "d")
    }

    var formattedYear: String {
        return format(dateFormat: "yyyy")
    }

    var formattedShortYear: String {
        return format(dateFormat: "yy")
    }

    var formattedISO8601Date: String {
        return DateFormatter.iso8601DateFormatter.string(from: self)
    }

    var formattedRFC822Date: String {
        return DateFormatter.rfc822DateFormatter.string(from: self)
    }

    var formattedSpanishMonthAndYear: String {
        return format(dateFormat: "MMMM yyyy",
                      formatter: .spanishDateFormatter)
    }

    var formattedSpanishMonthAndYearWithoutSpace: String {
        return format(dateFormat: "MMMM_yyyy",
                      formatter: .spanishDateFormatter)
    }

    var formattedSpanishMonth: String {
        return format(dateFormat: "MMMM",
                      formatter: .spanishDateFormatter)
    }

    var formattedSpanishShortMonth: String {
        return format(dateFormat: "MMM",
                      formatter: .spanishDateFormatter)
    }

    var isInTheFirstElevenDaysOfTheMonth: Bool {
        let day = Calendar.current.component(.day, from: self)
        return 1...11 ~= day
    }

    var isToday: Bool {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.isDateInToday(self)
    }

    func formattedSpanishDate(timeZone: TimeZone? = nil) -> String {
        return format(dateFormat: "dd 'de' MMMM",
                      timeZone: timeZone,
                      formatter: .spanishDateFormatter)
    }

    func formattedSpanishFullDate(timeZone: TimeZone? = nil) -> String {
        return format(dateFormat: "dd/MM/yyyy HH:mm",
                      timeZone: timeZone,
                      formatter: .spanishDateFormatter)
    }

    func formattedTime(timeZone: TimeZone? = nil) -> String {
        return format(dateFormat: "HH:mm",
                      timeZone: timeZone)
    }

    /**
     Calculate months to end dates, included days in last month or not
     
     - parameters:
     - endDate: date to
     - ignoringDays: boolean that indicate if calculate with days (By default included it)
     - returns: Amount of months between this dates (optional)
     */
    func monthsTo(_ endDate: Date, ignoringDays: Bool = false) -> Int {
        var startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        var endDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: endDate)
        startDateComponents.day = ignoringDays ? 1 : startDateComponents.day
        endDateComponents.day = ignoringDays ? 1 : endDateComponents.day

        return Calendar
            .current
            .dateComponents([.month],
                            from: startDateComponents,
                            to: endDateComponents).month!
    }

    // MARK: - Private methods

    private func format(dateFormat: String,
                        timeZone: TimeZone? = nil,
                        formatter: DateFormatter = DateFormatter()) -> String {

        formatter.dateFormat = dateFormat
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        return formatter.string(from: self)
    }
}

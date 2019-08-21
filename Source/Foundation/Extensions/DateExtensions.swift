import Foundation

public extension Date {

    /// Specify date format to convert
    ///
    /// - rfc3339: 2019-08-09T12:48:00.000+0200
    /// - rfc2822: Fri, 09 Aug 2019 12:48:00 +0200
    /// - rfc1123: Fri, 09 Aug 2019 12:48:00 GMT+2
    /// - spanishFullDateWithSlashes: 09/08/2019 12:48
    /// - americanFullDateWithSlashes: 08/09/2019 12:48
    /// - europeanFullDateWithSlashes: 2019/08/09 12:48
    /// - europeanDateWithDashes: 2019-08-09
    /// - time: 12:48
    /// - day: 9
    /// - shortMonth: aug
    /// - month: august
    /// - monthAndYear: august 2019
    /// - monthAndYearWithUnderscore: august_2019
    /// - shortYear: 19
    /// - year: 2019
    /// - spanishDayAndMonth: 09 de agosto
    enum Format: String, CaseIterable {
        case rfc3339 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case rfc2822 = "EEE, dd MMM yyyy HH:mm:ss Z"
        case rfc1123 = "EEE, dd MMM yyyy HH:mm:ss z"
        case spanishFullDateWithSlashes = "dd/MM/yyyy HH:mm"
        case americanFullDateWithSlashes = "MM/dd/yyyy HH:mm"
        case europeanFullDateWithSlashes = "yyyy/MM/dd HH:mm"
        case europeanDateWithDashes = "yyyy-MM-dd"
        case time = "HH:mm"
        case day = "d"
        case shortMonth = "MMM"
        case month = "MMMM"
        case monthAndYear = "MMMM yyyy"
        case monthAndYearWithUnderscore = "MMMM_yyyy"
        case shortYear = "yy"
        case year = "yyyy"
        case spanishDayAndMonth = "dd 'de' MMMM"

        func formatter(locale: Locale? = nil,
                       timeZone: TimeZone? = nil) -> DateFormatter {

            let dateFormatter = Formatter.date(locale: locale,
                                               timeZone: timeZone)
            dateFormatter.dateFormat = self.rawValue
            return dateFormatter
        }

        func date(formattedDate: String,
                  locale: Locale? = nil,
                  timeZone: TimeZone? = nil) -> Date? {

            let dateFormatter = formatter(locale: locale, timeZone: timeZone)
            return dateFormatter.date(from: formattedDate)
        }
    }

    /// Init Date with String and Date Format (if you don't specify it, will look for all Date Formats contemplated)
    ///
    /// - Parameters:
    ///   - formattedDate: String with date
    ///   - dateFormat: Format Date to convert (optional)
    ///   - locale: Language rules for date (optional) (by default use current)
    ///   - timeZone: Time zone to format date (optional) (by default use current)
    init?(formattedDate: String,
          dateFormat: Format? = nil,
          locale: Locale? = nil,
          timeZone: TimeZone? = nil) {
        if let dateFormat = dateFormat, let date = dateFormat.date(formattedDate: formattedDate, locale: locale, timeZone: timeZone) {
            self = date
            return
        }

        for dateFormat in Format.allCases {
            if let date = dateFormat.date(formattedDate: formattedDate,
                                          locale: locale,
                                          timeZone: timeZone) {
                self = date
                return
            }
        }
        return nil
    }

    /// Init Date with strategy that decodes dates in terms of milliseconds since midnight UTC on January 1st, 1970
    ///
    /// - Parameter millisecondsSince1970: milliseconds that corresponds with the date to parse
    init(millisecondsSince1970: Double) {
        self = Date(timeIntervalSince1970: millisecondsSince1970 / 1_000)
    }

    /// Milliseconds since midnight UTC on January 1st, 1970 that corresponds with Date
    var millisecondsSince1970: Double {
        return timeIntervalSince1970 * 1_000.0
    }

    /// Check if day in date is between day 1 and 11 of the month (included)
    var isInTheFirstElevenDaysOfTheMonth: Bool {
        let day = Calendar.current.component(.day, from: self)
        return 1...11 ~= day
    }

    /// Check if day in date corresponds with current day
    var isToday: Bool {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.isDateInToday(self)
    }

    /// Format Date in an string with specified format
    ///
    /// - Parameters:
    ///   - dateFormat: Date Format to convert
    ///   - locale: Language rules (optional) (by default use current)
    ///   - timeZone: Time zone to format date (optional) (by default use current)
    /// - Returns: Date formatted (optional)
    func formatted(with dateFormat: Date.Format,
                   locale: Locale? = nil,
                   timeZone: TimeZone? = nil) -> String? {

        let formatter = dateFormat.formatter(locale: locale,
                                             timeZone: timeZone)

        return formatter.string(from: self)
    }

    /// Calculate months to end dates, included days in last month or not
    ///
    /// - Parameters:
    ///   - endDate: date to
    ///   - ignoringDays: boolean that indicate if calculate with days (By default included it)
    /// - Returns: Amount of months between this dates (optional)
    func months(to endDate: Date, ignoringDays: Bool = false) -> Int {
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
}

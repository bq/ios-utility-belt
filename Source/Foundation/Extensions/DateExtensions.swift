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
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
        case rfc3339 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case rfc2822 = "EEE, dd MMM yyyy HH:mm:ss Z"
        case rfc1123 = "EEE, dd MMM yyyy HH:mm:ss z"
        case spanishDateWithSlashes = "dd/MM/yyyy"
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
        case dateStyleShort = "dateStyleShort"
        case dateStyleMedium = "dateStyleMedium"
        case dateStyleLong = "dateStyleLong"
        case dateStyleFull = "dateStyleFull"

        func formatter(locale: Locale? = nil,
                       timeZone: TimeZone? = nil) -> DateFormatter {

            let dateFormatter = Formatter.date(locale: locale,
                                               timeZone: timeZone)

            switch self {
            //For ISO8601 dates, if the timezone is UTC, use Z instead of +0000
            case .iso8601 where timeZone == .utc:
                dateFormatter.dateFormat = self.rawValue.replacingOccurrences(of: "Z", with: "'Z'")
            case .dateStyleShort:
                dateFormatter.dateStyle = .short
            case .dateStyleMedium:
                dateFormatter.dateStyle = .medium
            case .dateStyleLong:
                dateFormatter.dateStyle = .long
            case .dateStyleFull:
                dateFormatter.dateStyle = .full
            default:
                dateFormatter.dateFormat = self.rawValue
            }
            return dateFormatter
        }

        func date(formattedDate: String,
                  locale: Locale? = nil,
                  timeZone: TimeZone? = nil) -> Date? {

            let dateFormatter = formatter(locale: locale, timeZone: timeZone)
            var date = dateFormatter.date(from: formattedDate)

            //For ISO8601 dates, try to parse without seconds if the default input don't pass...
            if self == .iso8601 && date == nil {
                dateFormatter.dateFormat = dateFormatter.dateFormat.replacingOccurrences(of: ":ss", with: "")
                date = dateFormatter.date(from: formattedDate)
            }

            return date
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

    /// Return a new date by adding the given years
    func adding(years: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(year: years), to: self) else {
            fatalError("Cannot add \(years) years to date \(self)")
        }
        return newDate
    }

    /// Return a new date by adding the given days
    func adding(days: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(day: days), to: self) else {
            fatalError("Cannot add \(days) days to date \(self)")
        }
        return newDate
    }

    /// Return a new date by adding the given months
    func adding(months: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(month: months), to: self) else {
            fatalError("Cannot add \(months) months to date \(self)")
        }
        return newDate
    }

    /// Return a new date by adding the given hours
    func adding(hours: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(hour: hours), to: self) else {
            fatalError("Cannot add \(hours) hours to date \(self)")
        }
        return newDate
    }

    /// Return a new date by adding the given minutes
    func adding(minutes: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(minute: minutes), to: self) else {
            fatalError("Cannot add \(minutes) minutes to date \(self)")
        }
        return newDate
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

    /// Check if day in date is between day 1 and 3 of the month (included)
    var isInTheFirstThreeDaysOfTheMonth: Bool {
        let day = Calendar.current.component(.day, from: self)
        return 1...3 ~= day
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
    /// - Returns: Date formatted
    func formatted(with dateFormat: Date.Format,
                   locale: Locale? = nil,
                   timeZone: TimeZone? = nil) -> String {

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

    /// Calculate moment of day
    var dayMoment: DayMomentType {
        let dateComponents = Calendar.current.dateComponents([.hour], from: self)

        if let hour = dateComponents.hour {
            switch hour {
            case 7..<15:
                return .morning
            case 15..<21:
                return .afternoon
            default:
                return .night
            }
        }
        return .morning
    }

    /// Give the previous month name from current Date
    static func previousMonthName(locale: Locale = .spanishSpain) -> String {
        return Date().adding(months: -1).formatted(with: .month, locale: .spanishSpain)
    }
}

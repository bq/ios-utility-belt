import XCTest
import Foundation
import MagicPills

class DateExtensionsTests: XCTestCase {
    func test_init_from_formatted_dates() {
        let rfcDate = Date(formattedDate: "2019-08-09T12:48:00.000+0200",
                           dateFormat: .rfc3339,
                           timeZone: .madrid)
        XCTAssertNotNil(rfcDate)

        let invalidDate = Date(formattedDate: "⚠️")
        XCTAssertNil(invalidDate)

        let spanishDate = Date(formattedDate: "20/02/2018 12:33",
                               timeZone: .madrid)
        XCTAssertNotNil(spanishDate)
    }

    func test_init_with_milliseconds() {
        let milliseconds: Double = 12_408_124_000
        let date = Date(millisecondsSince1970: milliseconds)

        XCTAssertEqual(date.millisecondsSince1970, milliseconds)
    }

    func test_init_with_rfc3339date() {
        let rfc3339Date = "2019-08-09T10:48:00.000+0200"
        let date = rfc3339Date.date()

        XCTAssertEqual(date?.formatted(with: .rfc3339,
                                       timeZone: .madrid),
                       rfc3339Date)
        XCTAssertNil("👋".date())
    }

    func test_init_with_formatted_spanishDate() {
        let spanishFullDate = "20/02/2018 12:33"
        var date = Date(formattedDate: spanishFullDate,
                        timeZone: .madrid)

        XCTAssertEqual(date?.formatted(with: .spanishFullDateWithSlashes,
                                       timeZone: .madrid),
                       spanishFullDate)

        XCTAssertEqual(date?.formatted(with: .spanishFullDateWithSlashes,
                                       timeZone: .utc),
                       "20/02/2018 11:33")

        let summerSpanishFullDate = "20/08/2018 12:33"
        date = Date(formattedDate: summerSpanishFullDate,
                    timeZone: .madrid)

        XCTAssertEqual(date?.formatted(with: .spanishFullDateWithSlashes,
                                       timeZone: .madrid),
                       summerSpanishFullDate)

        XCTAssertEqual(date?.formatted(with: .spanishFullDateWithSlashes,
                                       timeZone: .utc),
                       "20/08/2018 10:33")
    }

    func test_date_formats() {
        let date = Date(formattedDate: "09/08/2019 10:48", timeZone: .utc)!

        XCTAssertEqual(date.formatted(with: .rfc3339, timeZone: .madrid), "2019-08-09T12:48:00.000+0200")
        XCTAssertEqual(date.formatted(with: .rfc2822, locale: .englishUSA, timeZone: .madrid), "Fri, 09 Aug 2019 12:48:00 +0200")
        XCTAssertEqual(date.formatted(with: .rfc1123, locale: .englishUSA, timeZone: .madrid), "Fri, 09 Aug 2019 12:48:00 GMT+2")
        XCTAssertEqual(date.formatted(with: .spanishFullDateWithSlashes, timeZone: .madrid), "09/08/2019 12:48")
        XCTAssertEqual(date.formatted(with: .americanFullDateWithSlashes, timeZone: .madrid), "08/09/2019 12:48")
        XCTAssertEqual(date.formatted(with: .europeanFullDateWithSlashes, timeZone: .madrid), "2019/08/09 12:48")
        XCTAssertEqual(date.formatted(with: .europeanDateWithDashes, timeZone: .madrid), "2019-08-09")
        XCTAssertEqual(date.formatted(with: .time, timeZone: .madrid), "12:48")
        XCTAssertEqual(date.formatted(with: .day), "9")
        XCTAssertEqual(date.formatted(with: .shortMonth, locale: .spanishSpain), "ago")
        XCTAssertEqual(date.formatted(with: .month, locale: .spanishSpain), "agosto")
        XCTAssertEqual(date.formatted(with: .monthAndYear, locale: .spanishSpain), "agosto 2019")
        XCTAssertEqual(date.formatted(with: .monthAndYearWithUnderscore, locale: .spanishSpain), "agosto_2019")
        XCTAssertEqual(date.formatted(with: .shortYear), "19")
        XCTAssertEqual(date.formatted(with: .year), "2019")
        XCTAssertEqual(date.formatted(with: .spanishDayAndMonth, locale: .spanishSpain, timeZone: .madrid), "09 de agosto")
    }

    func test_is_today() {
        XCTAssertTrue(Date().isToday)
        XCTAssertFalse(Date().addingTimeInterval(-86_400).isToday)
    }

    func test_is_in_the_first_eleven_days_of_the_month() {
        stride(from: 1, to: 31, by: 1).forEach { day in
            let date = "\(day)/01/2018 11:11".date()

            XCTAssertEqual(date?.isInTheFirstElevenDaysOfTheMonth, day <= 11)
        }
    }

    func test_months_between_dates() {
        var date1 = Date(formattedDate: "20/02/2018 12:33", timeZone: .madrid)!
        var date2 = Date(formattedDate: "19/06/2018 12:33", timeZone: .madrid)!
        XCTAssertEqual(date1.months(to: date2), 3)

        date1 = Date(formattedDate: "19/02/2018 12:33", timeZone: .madrid)!
        date2 = Date(formattedDate: "19/06/2018 12:33", timeZone: .madrid)!
        XCTAssertEqual(date1.months(to: date2), 4)

        date1 = Date(formattedDate: "25/02/2018 12:33", timeZone: .madrid)!
        date2 = Date(formattedDate: "19/06/2018 12:33", timeZone: .madrid)!
        XCTAssertEqual(date1.months(to: date2, ignoringDays: true), 4)
    }
}

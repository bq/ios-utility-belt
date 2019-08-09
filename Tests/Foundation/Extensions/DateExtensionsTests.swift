import XCTest
import Foundation
import MagicPills

class DateExtensionsTests: XCTestCase {
    func test_init_with_milliseconds() {
        let milliseconds: Double = 12_408_124_000
        let date = Date(millisecondsSince1970: milliseconds)

        XCTAssertEqual(date.millisecondsSince1970, milliseconds)
    }

    func test_init_with_formatted_spanishDate() {
        let spanishFullDate = "20/02/2018 12:33"
        let date = Date(formattedSpanishFullDate: spanishFullDate)

        XCTAssertEqual(date?.formattedSpanishFullDate(), spanishFullDate)
        XCTAssertNil(Date(formattedSpanishFullDate: "👋"))
    }

    func test_init_with_iso8601date() {
        let iso8601Date = "2019-08-09T10:48:00.000+0000"
        let date = Date(iso8601Date: iso8601Date)

        XCTAssertEqual(date?.formattedISO8601Date, iso8601Date)
        XCTAssertNil(Date(iso8601Date: "👋"))
    }

    func test_init_with_rfc822Date() {
        let rfc822Date = "Fri, 09 Aug 2019 10:48:00 GMT"
        let date = Date(rfc822Date: rfc822Date)

        XCTAssertEqual(date?.formattedRFC822Date, rfc822Date)
        XCTAssertNil(Date(rfc822Date: "👋"))
    }

    func test_date_parts() {
        let timeZone = TimeZone(secondsFromGMT: 3_600)
        let date = Date(formattedSpanishFullDate: "20/02/2018 12:33", timeZone: timeZone)

        XCTAssertEqual(date?.day, "20")
        XCTAssertEqual(date?.monthSpanishName, "febrero")
        XCTAssertEqual(date?.monthSpanishNameAndYear, "febrero 2018")
        XCTAssertEqual(date?.shortMonthSpanishName, "feb")
        XCTAssertEqual(date?.year, "2018")
        XCTAssertEqual(date?.shortYear, "18")
        XCTAssertEqual(date?.day, "20")
    }

    func test_spanish_format_date() {
        let date = Date(millisecondsSince1970: 1_214_124_999_000)

        XCTAssertEqual(date.formattedSpanishFullDate(timeZone: TimeZone(secondsFromGMT: 0)), "22/06/2008 08:56")
        XCTAssertEqual(date.formattedSpanishFullDate(timeZone: TimeZone(secondsFromGMT: 3_600)), "22/06/2008 09:56")
        XCTAssertEqual(date.formattedSpanishDate(timeZone: TimeZone(secondsFromGMT: 0)), "22 de junio")
        XCTAssertEqual(date.formattedSpanishDate(timeZone: TimeZone(secondsFromGMT: 3_600)), "22 de junio")
    }

    func test_is_today() {
        XCTAssertTrue(Date().isToday)
        XCTAssertFalse(Date().addingTimeInterval(-86_400).isToday)
    }

    func test_is_in_the_first_eleven_days_of_the_month() {
        stride(from: 1, to: 31, by: 1).forEach { day in
            let date = Date(formattedSpanishFullDate: "\(day)/01/2018 11:11")

            XCTAssertEqual(date?.isInTheFirstElevenDaysOfTheMonth, day <= 11)
        }
    }

    func test_time_format() {
        let expectedResult = "22:31"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2016/10/12 22:31")
        let timeDate = someDateTime?.formattedTime()
        XCTAssertEqual(timeDate, expectedResult)
    }

    func test_ISO8601_formatted_date() {
        let spanishFullDate = "09/08/2019 10:48"
        let expectedResult = "2019-08-09T10:48:00.000+0000"
        let date = Date(formattedSpanishFullDate: spanishFullDate, timeZone: TimeZone(secondsFromGMT: 0))
        XCTAssertEqual(date?.formattedISO8601Date, expectedResult)
    }

    func test_RFC822_formatted_date() {
        let spanishFullDate = "09/08/2019 10:48"
        let expectedResult = "Fri, 09 Aug 2019 10:48:00 GMT"
        let date = Date(formattedSpanishFullDate: spanishFullDate, timeZone: TimeZone(secondsFromGMT: 0))
        XCTAssertEqual(date?.formattedRFC822Date, expectedResult)
    }
}

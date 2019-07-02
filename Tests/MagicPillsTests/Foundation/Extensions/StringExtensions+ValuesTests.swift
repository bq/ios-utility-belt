import XCTest
import Foundation
import MagicPills

class StringExtensionsValuesTests: XCTestCase {
    func test_bool_value() {
        XCTAssertEqual("true".boolValue, true)
        XCTAssertEqual("True".boolValue, true)
        XCTAssertEqual("yes".boolValue, true)
        XCTAssertEqual("Yes".boolValue, true)
        XCTAssertEqual("1".boolValue, true)

        XCTAssertEqual("false".boolValue, false)
        XCTAssertEqual("False".boolValue, false)
        XCTAssertEqual("no".boolValue, false)
        XCTAssertEqual("No".boolValue, false)
        XCTAssertEqual("0".boolValue, false)

        XCTAssertNil("".boolValue)
        XCTAssertNil("wawa".boolValue)
    }

    func test_url_value() {
        XCTAssertNil("".urlValue)
        XCTAssertEqual("http://www.google.com".urlValue, URL(string: "http://www.google.com"))
    }

    func test_date_value() {
        XCTAssertEqual("2018".dateValue(timeZone: TimeZone(secondsFromGMT: 0)),
                       Date(formattedSpanishFullDate: "01/01/2018 00:00", timeZone: TimeZone(secondsFromGMT: 0)))
        XCTAssertEqual("2015-05-20T12:00:00.000Z".dateValue(),
                       Date(formattedSpanishFullDate: "20/05/2015 12:00", timeZone: TimeZone(secondsFromGMT: 0)))
        XCTAssertEqual("2018-12-25".dateValue(timeZone: TimeZone(secondsFromGMT: 0)),
                       Date(formattedSpanishFullDate: "25/12/2018 00:00", timeZone: TimeZone(secondsFromGMT: 0)))

        XCTAssertNil("".dateValue())
        XCTAssertNil("wawa".dateValue())
    }
}

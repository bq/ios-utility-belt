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
        XCTAssertEqual("2018".date(),
                       "01/01/2018 00:00".date())
        XCTAssertEqual("2015-05-20T12:00:00.000Z".date(),
                       "20/05/2015 12:00".date())
        XCTAssertEqual("2018-12-25".date(),
                       "25/12/2018 00:00".date())

        XCTAssertNil("".date())
        XCTAssertNil("wawa".date())
    }
}

import XCTest
import Foundation
import MagicPills

class StringExtensionsFormatingTests: XCTestCase {
    func test_underlined() {
        let string = "hola"
        let attr = string.underLined

        let bodyAttributesLower = attr.attributes(at: 0, effectiveRange: nil)
        let bodyAttributesUpper = attr.attributes(at: string.count - 1, effectiveRange: nil)

        XCTAssertEqual(bodyAttributesLower[.underlineStyle] as? Int, 1)
        XCTAssertEqual(bodyAttributesUpper[.underlineStyle] as? Int, 1)
    }

    func test_format_phone() {
        XCTAssertEqual("123".formattedAsPhoneNumber, "123")
        XCTAssertEqual("1231".formattedAsPhoneNumber, "123 1")
        XCTAssertEqual("12312".formattedAsPhoneNumber, "123 12")
        XCTAssertEqual("123123".formattedAsPhoneNumber, "123 123")
        XCTAssertEqual("1231234".formattedAsPhoneNumber, "123 123 4")
        XCTAssertEqual("12312345".formattedAsPhoneNumber, "123 123 45")
        XCTAssertEqual("123123123".formattedAsPhoneNumber, "123 123 123")
        XCTAssertEqual("".formattedAsPhoneNumber, "")
    }
}

import XCTest
import Foundation
import MagicPills
import UIKit

class StringExtensionsUIKitTests: XCTestCase {
    func test_attributed() {
        let font = UIFont.systemFont(ofSize: 10)
        let string = "hola mundo"
        let attr = string.attributed(lineSpace: 12, paragraphSpace: 10, font: font)

        let paragraphStyle = attr.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle
        let fontStyle = attr.attribute(.font, at: 0, effectiveRange: nil) as? UIFont

        XCTAssertEqual(paragraphStyle?.lineSpacing, 12)
        XCTAssertEqual(paragraphStyle?.paragraphSpacing, 10)
        XCTAssertEqual(fontStyle, font)
    }

    func test_attributed_link() {
        let string = "hola chau"
        let link = "chau"
        let bodyColor = UIColor.red
        let linkColor = UIColor.green
        let attr = string.attributedLink(link,
                                         bodyTextColor: bodyColor,
                                         linkTextColor: linkColor)
        let linkRange = string.nsRange(of: link)!

        let bodyAttributes = attr.attributes(at: 0, effectiveRange: nil)
        let linkAttributesLower = attr.attributes(at: linkRange.lowerBound, effectiveRange: nil)
        let linkAttributesUpper = attr.attributes(at: linkRange.upperBound - 1, effectiveRange: nil)

        XCTAssertEqual(linkAttributesLower[.foregroundColor] as? UIColor, linkColor)
        XCTAssertEqual(linkAttributesUpper[.foregroundColor] as? UIColor, linkColor)
        XCTAssertEqual(bodyAttributes[.foregroundColor] as? UIColor, bodyColor)
    }

    func test_attributed_last_character() {
        let string = "500 GB"
        let font = UIFont.boldSystemFont(ofSize: 40)
        let attr = string.attributedLastCharacters(2, font: font)

        let unitRange = string.nsRange(of: "GB")!
        let bodyAttributes = attr.attributes(at: 0, effectiveRange: nil)
        let unitAttributesLower = attr.attributes(at: unitRange.lowerBound, effectiveRange: nil)
        let unitAttributesUpper = attr.attributes(at: unitRange.upperBound - 1, effectiveRange: nil)

        XCTAssertEqual(unitAttributesLower[.font] as? UIFont, font)
        XCTAssertEqual(unitAttributesUpper[.font] as? UIFont, font)
        XCTAssertNil(bodyAttributes[.font])
    }

    func test_attributed_last_character_with_more_characters_than_lenght() {
        let string = "RGB"
        let font = UIFont.boldSystemFont(ofSize: 40)
        let attr = string.attributedLastCharacters(4, font: font)

        let bodyAttributesLower = attr.attributes(at: 0, effectiveRange: nil)
        let bodyAttributesUpper = attr.attributes(at: string.count - 1, effectiveRange: nil)

        XCTAssertEqual(bodyAttributesLower[.font] as? UIFont, font)
        XCTAssertEqual(bodyAttributesUpper[.font] as? UIFont, font)
    }
}

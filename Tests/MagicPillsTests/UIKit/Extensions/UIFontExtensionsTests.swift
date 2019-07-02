import XCTest
import Foundation
import MagicPills

class UIFontExtensionsTests: XCTestCase {

    func test_font_bold() {
        let originalFont = UIFont(name: "Helvetica", size: 14)
        let boldedFont = originalFont?.bold

        XCTAssertTrue(boldedFont?.fontDescriptor.symbolicTraits.contains(.traitBold) ?? false)
    }

    func test_font_italic() {
        let originalFont = UIFont(name: "Helvetica", size: 14)
        let boldedFont = originalFont?.italic

        XCTAssertTrue(boldedFont?.fontDescriptor.symbolicTraits.contains(.traitItalic) ?? false)
    }

    func test_font_bold_italic() {
        let originalFont = UIFont(name: "Helvetica", size: 14)
        let boldedFont = originalFont?.boldItalic

        XCTAssertTrue(boldedFont?.fontDescriptor.symbolicTraits.contains([.traitItalic, .traitBold]) ?? false)
    }

    func test_font_system_regular() {
        XCTAssertEqual(UIFont.systemRegular(size: 14),
                       UIFont.systemFont(ofSize: 14, weight: .regular))

        XCTAssertEqual(UIFont.systemBold(size: 14),
                       UIFont.systemFont(ofSize: 14, weight: .bold))

        XCTAssertEqual(UIFont.systemMedium(size: 14),
                       UIFont.systemFont(ofSize: 14, weight: .medium))

        XCTAssertEqual(UIFont.systemLight(size: 14),
                       UIFont.systemFont(ofSize: 14, weight: .light))
    }
}

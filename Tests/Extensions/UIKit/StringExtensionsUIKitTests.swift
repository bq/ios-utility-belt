import XCTest
import Foundation
import MagicPills

class StringExtensionsUIKitTests: XCTestCase {

    func test_format_last_character() {
        let string = "500 GB"
        let font = UIFont.boldSystemFont(ofSize: 40)
        let attributedText = string.attributeLastCharacters(2, font: font)
        let fullRange = NSRange(location: 0, length: attributedText.length)
        let unitRange = string.firstRangeOcurrence("GB")!
        var foundFont: UIFont?
        attributedText
            .enumerateAttribute(.font,
                                in: fullRange,
                                options: [.longestEffectiveRangeNotRequired]) { value, range, _ in
                                    if range == unitRange, let font = value as? UIFont {
                                        foundFont = font
                                    }
            }

        XCTAssertEqual(foundFont, font)
    }

    func test_format_last_character_with_more_characters_than_lenght() {
        let string = "RGB"
        let font = UIFont.boldSystemFont(ofSize: 40)
        let attributedText = string.attributeLastCharacters(4, font: font)
        let fullRange = NSRange(location: 0, length: attributedText.length)
        var foundFont: UIFont?

        attributedText
            .enumerateAttribute(.font,
                                in: fullRange,
                                options: [.longestEffectiveRangeNotRequired]) { value, _, _ in
                                    if let font = value as? UIFont {
                                        foundFont = font
                                    }
            }

        XCTAssertEqual(foundFont, font)
    }

    func test_format_lineSpace_paragraphSpace_font() {
        let text = "Lorem ipsum dolor sit amet consectetur adipiscing elit iaculis, semper faucibus habitasse tempor tempus vehicula fusce porta risus, lobortis ac metus leo commodo in tortor."

        guard let attributedText = text.attribute(lineSpace: 2,
                                               paragraphSpace: 3,
                                               font: UIFont.boldSystemFont(ofSize: 40)) else {

                                                XCTFail("Unable to format last characters")
                                                return
        }

        let fullRange = NSRange(location: 0, length: attributedText.length)
        var foundStyle: NSMutableParagraphStyle?
        var foundFont: UIFont?

        attributedText
            .enumerateAttribute(.paragraphStyle,
                                in: fullRange,
                                options: [.longestEffectiveRangeNotRequired]) { value, _, _ in
                                    if let style = value as? NSMutableParagraphStyle {
                                        foundStyle = style
                                    }
            }

        attributedText
            .enumerateAttribute(.font,
                                in: fullRange,
                                options: [.longestEffectiveRangeNotRequired]) { value, _, _ in
                                    if let font = value as? UIFont {
                                        foundFont = font
                                    }
            }

        XCTAssertEqual(2, foundStyle?.lineSpacing)
        XCTAssertEqual(3, foundStyle?.paragraphSpacing)
        XCTAssertEqual(foundFont, UIFont.boldSystemFont(ofSize: 40))
    }

    func test_attributed_bold() {
        let text = "Lorem ipsum dolor sit amet consectetur adipiscing elit iaculis"
        guard let attributedText = text.bold("consectetur",
                                             font: UIFont(name: "Helvetica", size: 14)!,
                                             boldColor: .black) else {
                                                XCTFail("Unable to format last characters")
                                                return
        }

        let fullRange = NSRange(location: 0, length: attributedText.length)
        let boldedRange = text.firstRangeOcurrence("consectetur")!
        var foundFont: UIFont?
        var foundColor: UIColor?

        attributedText
            .enumerateAttribute(.font,
                                in: fullRange,
                                options: [.longestEffectiveRangeNotRequired]) { value, range, _ in
                                    if range == boldedRange, let font = value as? UIFont {
                                        foundFont = font
                                    }
            }

        attributedText
            .enumerateAttribute(.foregroundColor,
                                in: fullRange,
                                options: [.longestEffectiveRangeNotRequired]) { value, range, _ in
                                    if range == boldedRange, let color = value as? UIColor {
                                        foundColor = color
                                    }
            }

        XCTAssertTrue(foundFont?.fontDescriptor.symbolicTraits.contains(.traitBold) ?? false)
        XCTAssertEqual(foundColor, .black)
    }

    func test_first_range_text_ocurrence() {
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit."

        let foundRange = text.firstRangeOcurrence("ipsum")
        let expectedRange = NSRange(location: 6, length: "ipsum".count)

        XCTAssertEqual(foundRange, expectedRange)
    }

    func test_ranges_text_ocurrences() {
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit."

        let foundRanges = text.rangesOcurrences("ipsum")
        let expectedRanges = [NSRange(location: 6, length: "ipsum".count),
                              NSRange(location: 63, length: "ipsum".count)]

        XCTAssertEqual(foundRanges, expectedRanges)
    }
}

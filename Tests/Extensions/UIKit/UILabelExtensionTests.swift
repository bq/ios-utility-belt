import XCTest
import Foundation
import MagicPills

class UILabelExtensionsTests: XCTestCase {

    func test_highlight_text() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.font = UIFont(name: "Helvetica", size: 14)
        label.text = "Lorem ipsum dolor sit amet consectetur adipiscing elit iaculis"
        guard let attributedText = label.attributedText else {
            XCTFail("Label haven't attributed text")
            return
        }

        label.highlight("consectetur")

        let fullRange = NSRange(location: 0, length: attributedText.length)
        let highlightedRange = label.text?.firstRangeOcurrence("consectetur")
        var foundFont: UIFont?

        label.attributedText?
            .enumerateAttribute(.font,
                                in: fullRange,
                                options: [.longestEffectiveRangeNotRequired]) { value, range, _ in
                                    if range == highlightedRange,
                                        let font = value as? UIFont {
                                        foundFont = font
                                    }
            }

        XCTAssertTrue(foundFont?.fontDescriptor.symbolicTraits.contains(.traitBold) ?? false)
    }
}

import XCTest
import Foundation
import MagicPills

class SequenceExtensionsTests: XCTestCase {
    func test_group() {
        let elements = ["AA", "AB", "BB"]

        let grouped = elements.group(by: { String($0.prefix(1)) })

        XCTAssertEqual(grouped.keys.count, 2)
        XCTAssertEqual(grouped["A"], ["AA", "AB"])
        XCTAssertEqual(grouped["B"], ["BB"])
    }
}

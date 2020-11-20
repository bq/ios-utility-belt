import XCTest
import Foundation
import MasMagicPills

class OptionalTypeTests: XCTestCase {
    func test_wrapped_value() {
        let optional: String? = "pole"
        let another: Date? = nil

        XCTAssertEqual(optional.wrapped, optional)
        XCTAssertEqual(another.wrapped, another)
    }

    func test_filter_nil() {
        let array: [String?] = ["uno", nil, "dos", nil]

        XCTAssertEqual(array.filterNils, ["uno", "dos"])
    }
}

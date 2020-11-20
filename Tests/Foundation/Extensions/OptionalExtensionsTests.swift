import XCTest
import Foundation
import MasMagicPills

class OptionalExtensionsTests: XCTestCase {
    func test_is_not_nil() {
        let nothing: String? = "pole"

        XCTAssertNotNil(nothing)
        XCTAssertTrue(nothing.isNotNil)
    }

    func test_is_nil() {
        let nothing: String? = nil

        XCTAssertNil(nothing)
        XCTAssertTrue(nothing.isNil)
    }

    func test_is_falsy_for_bool_wrapped() {
        let nilValue: Bool? = nil
        let trueValue: Bool? = true
        let falseValue: Bool? = false

        XCTAssertNil(nilValue)
        XCTAssertFalse(nilValue.isFalsy)

        XCTAssertNotNil(trueValue)
        XCTAssertFalse(trueValue.isFalsy)

        XCTAssertNotNil(falseValue)
        XCTAssertTrue(falseValue.isFalsy)
    }

    func test_is_truthy_for_bool_wrapped() {
        let nilValue: Bool? = nil
        let trueValue: Bool? = true
        let falseValue: Bool? = false

        XCTAssertNil(nilValue)
        XCTAssertFalse(nilValue.isTruthy)

        XCTAssertNotNil(trueValue)
        XCTAssertTrue(trueValue.isTruthy)

        XCTAssertNotNil(falseValue)
        XCTAssertFalse(falseValue.isTruthy)
    }
}

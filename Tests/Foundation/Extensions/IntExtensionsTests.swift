import XCTest
import Foundation
import MagicPills

class IntExtensionsTests: XCTestCase {
    func test_int_to_string_conversion() {
        XCTAssertEqual((24 as Int).string, "24")
        XCTAssertEqual((1_024 as Int).string, "1024")
        XCTAssertNotEqual((1_024 as Int).string, "10")
    }
}

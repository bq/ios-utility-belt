import XCTest
import Foundation
import MasMagicPills

class BoolExtensionsTests: XCTestCase {
    func test_is_false() {
        XCTAssertTrue(false.isFalse)
        XCTAssertFalse(true.isFalse)
    }
}

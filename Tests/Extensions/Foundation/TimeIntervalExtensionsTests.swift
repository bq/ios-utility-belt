import XCTest
import Foundation
import MagicPills

class TimeIntervalExtensionsTests: XCTestCase {
    func test_formatted_for_positive_values() {
        XCTAssertEqual((1_412 as TimeInterval).formatted, "1s")
        XCTAssertEqual((112 as TimeInterval).formatted, "0s")
        XCTAssertEqual((332_412 as TimeInterval).formatted, "5m 32s")
        XCTAssertEqual((12_412 as TimeInterval).formatted, "12s")
        XCTAssertEqual((124_421 as TimeInterval).formatted, "2m 4s")
        XCTAssertEqual((5_332_412 as TimeInterval).formatted, "1h 28m 52s")
        XCTAssertEqual((2_332_412 as TimeInterval).formatted, "38m 52s")
    }

    func test_formatted_for_negative_values() {
        XCTAssertEqual((-2_332_412 as TimeInterval).formatted, "-38m 52s")
        XCTAssertEqual((-332_412 as TimeInterval).formatted, "-5m 32s")
        XCTAssertEqual((-60_000 as TimeInterval).formatted, "-1m 0s")
        XCTAssertEqual((-1_000 as TimeInterval).formatted, "-1s")
        XCTAssertEqual((-412 as TimeInterval).formatted, "0s")
    }
}

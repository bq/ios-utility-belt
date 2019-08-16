import XCTest
import Foundation
import MagicPills

class CGFloatExtensionsTests: XCTestCase {
    func test_convert_degrees_to_radianas() {
        let degrees: CGFloat = 90
        let radians: CGFloat = degrees.radians
        XCTAssertEqual(degrees, 90)
        XCTAssertEqual(radians, 1.570_796_326_794_896_6)
    }
}

import XCTest
import Foundation
import MasMagicPills

class DoubleExtensionsTests: XCTestCase {

    func test_double_to_nsnumber_conversion() {
        let expectedResultDouble: Double = 20_0000
        let expectedResultNumber = expectedResultDouble.asNSNumber
        XCTAssertEqual(expectedResultDouble, expectedResultNumber.doubleValue)
    }
}

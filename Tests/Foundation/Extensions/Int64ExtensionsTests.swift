import XCTest
import Foundation
import MasMagicPills

class Int64ExtensionsTests: XCTestCase {
    func test_static_helpers() {
        let sixGigaBytes = Int64.gigaBytes(6)
        XCTAssertEqual(sixGigaBytes, 6 * 1_024 * 1_024 * 1_024)

        let twentyFiveMegaBytes = Int64.megaBytes(25)
        XCTAssertEqual(twentyFiveMegaBytes, 25 * 1_024 * 1_024)
    }

    func test_int_to_string_conversion() {
        XCTAssertEqual((24 as Int64).toString, "24")
        XCTAssertEqual((1_024 as Int64).toString, "1024")
        XCTAssertNotEqual((1_024 as Int64).toString, "10")
    }
    
    func test_int_to_nsnumber_conversion() {
        let expectedResultInt = 20
        let expectedResultNumber = expectedResultInt.asNSNumber
        XCTAssertEqual(expectedResultInt, expectedResultNumber.intValue)
    }
}

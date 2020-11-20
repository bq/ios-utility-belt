import XCTest
import Foundation
import MasMagicPills

class IntExtensionsTests: XCTestCase {
    func test_int_to_string_conversion() {
        XCTAssertEqual((24 as Int).toString, "24")
        XCTAssertEqual((1_024 as Int).toString, "1024")
        XCTAssertNotEqual((1_024 as Int).toString, "10")
    }
    
    func test_int_to_nsnumber_conversion() {
        let expectedResultInt = 20
        let expectedResultNumber = expectedResultInt.asNSNumber
        XCTAssertEqual(expectedResultInt, expectedResultNumber.intValue)
    }
}

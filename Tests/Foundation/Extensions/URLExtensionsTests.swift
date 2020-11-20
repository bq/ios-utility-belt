import XCTest
import Foundation
import MasMagicPills

class URLExtensionsTests: XCTestCase {
    func test_comparable() {
        let url1 = URL(string: "http://aaa.com")!
        let url2 = URL(string: "http://bbb.com")!

        XCTAssertTrue(url1 < url2)
        XCTAssertFalse(url1 > url2)
    }
}

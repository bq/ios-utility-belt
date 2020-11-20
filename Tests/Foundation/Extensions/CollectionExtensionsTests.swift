import XCTest
import Foundation
import MasMagicPills

class CollectionExtensionsTests: XCTestCase {
    func test_isNotEmpty() {
        var collection = [String]()
        XCTAssertFalse(collection.isNotEmpty)

        collection.append("hi")
        XCTAssertTrue(collection.isNotEmpty)

        collection.removeAll()
        XCTAssertFalse(collection.isNotEmpty)
    }
}

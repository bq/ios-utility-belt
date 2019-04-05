import XCTest
import Foundation
import MagicPills

class ArrayExtensionsTests: XCTestCase {
    func test_unique() {
        XCTAssertEqual([1, 1, 2, 2, 3].unique.sorted(), [1, 2, 3].sorted())
    }

    func test_remove_existing_object() {
        var array = ["a", "b", "c", "d", "e"]

        XCTAssertTrue(array.remove("c"))
        XCTAssertEqual(array, ["a", "b", "d", "e"])
    }

    func test_remove_unexisting_object() {
        var array = ["a", "b", "c", "d", "e"]

        XCTAssertFalse(array.remove("f"))
        XCTAssertEqual(array, ["a", "b", "c", "d", "e"])
    }

    func test_append_if_not_exists() {
        var array = ["a", "b"]
        XCTAssertTrue(array.appendIfNotExists("c"))
        XCTAssertFalse(array.appendIfNotExists("c"))
        XCTAssertEqual(array, ["a", "b", "c"])
    }
}

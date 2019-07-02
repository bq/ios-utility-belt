import XCTest
import Foundation
import MagicPills

class SharedDictionaryTests: XCTestCase {
    func test_init() {
        let sharedDictionary = SharedDictionary<String, Int>()

        XCTAssertEqual(sharedDictionary.innerDictionary, [:])
    }

    func test_getorput() {
        let sharedDictionary = SharedDictionary<String, Int>()

        let value = sharedDictionary.getOrPut("a", defaultValue: { 4 })

        XCTAssertEqual(value, sharedDictionary.get(withKey: "a"))
        XCTAssertEqual(sharedDictionary.innerDictionary, ["a": 4])
    }
}

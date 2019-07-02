import XCTest
import Foundation
import MagicPills

class DictionaryExtensionsTests: XCTestCase {
    func test_getorput() {
        var dictionary = ["a": 1, "b": 2]

        dictionary.keys.forEach { key in
            let value = dictionary.getOrPut(key) {
                XCTFail("This never been called because key must exists in the dictionary")
                return 3
            }
            XCTAssertEqual(value, dictionary[key])
        }
        XCTAssertEqual(dictionary.keys.count, 2)

        XCTAssertEqual(dictionary.getOrPut("c", defaultValue: { 3 }), 3)
        XCTAssertEqual(dictionary.keys.count, 3)
    }
}

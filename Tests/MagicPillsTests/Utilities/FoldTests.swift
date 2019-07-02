import XCTest
import Foundation
import MagicPills

class FoldTests: XCTestCase {
    func test_closure_parameters() {
        let call1 = expectation(description: "Call for fold closure with initial value and param1")
        let call2 = expectation(description: "Call for fold closure with first response and param2")

        let initialValue = 1
        let response = 5
        let param1 = "2"
        let param2 = "a"

        let result = fold(initial: initialValue, list: [param1, param2]) { value, param in
            if value == initialValue, param == param1 {
                call1.fulfill()
            }
            if value == response + initialValue, param == param2 {
                call2.fulfill()
            }

            return value + response
        }

        XCTAssertEqual(result, (response + response + initialValue))

        waitForExpectations(timeout: 5)
    }

    func test_composing_word() {
        let word = fold(initial: "HO", list: ["L", "A"]) { value, param in
            return value + param
        }

        XCTAssertEqual(word, "HOLA")
    }
}

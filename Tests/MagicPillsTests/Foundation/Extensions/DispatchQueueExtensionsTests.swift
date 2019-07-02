import Foundation
import XCTest

class DispatchQueueExtensionsTests: XCTestCase {
    func test_ismain() {
        let checks = expectation(description: "Check for async validations")
        checks.expectedFulfillmentCount = 2

        DispatchQueue.global(qos: .background).async {
            XCTAssertFalse(DispatchQueue.isMain)
            checks.fulfill()
        }

        DispatchQueue.main.async {
            XCTAssertTrue(DispatchQueue.isMain)
            checks.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}

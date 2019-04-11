import XCTest
import Foundation
import MagicPills

class BundleExtensionsTests: XCTestCase {
    func test_version_number() {
        let expectedVersionNumber = "2.2.2"
        let bundle = FakeBundle()
        bundle.versionNumberValue = expectedVersionNumber

        XCTAssertEqual(bundle.versionNumber, expectedVersionNumber)
    }

    func test_build_number() {
        let expectedBuildNumber = "24"
        let bundle = FakeBundle()
        bundle.buildNumberValue = expectedBuildNumber

        XCTAssertEqual(bundle.buildNumber, expectedBuildNumber)
    }

    func test_full_version_number_when_value_are_different() {
        let expectedVersionNumber = "2.2.2"
        let expectedBuildNumber = "24"
        let bundle = FakeBundle()
        bundle.versionNumberValue = expectedVersionNumber
        bundle.buildNumberValue = expectedBuildNumber

        XCTAssertEqual("v\(expectedVersionNumber)(\(expectedBuildNumber))", bundle.fullVersionNumber)
    }

    func test_full_version_number_when_value_are_equals() {
        let expectedVersionNumber = "2.2.2"
        let expectedBuildNumber = "2.2.2"
        let bundle = FakeBundle()
        bundle.versionNumberValue = expectedVersionNumber
        bundle.buildNumberValue = expectedBuildNumber

        XCTAssertEqual("v\(expectedVersionNumber)", bundle.fullVersionNumber)
    }

    func test_full_version_number_when_value_are_not_present() {
        let bundle = FakeBundle()
        bundle.versionNumberValue = nil
        bundle.buildNumberValue = nil

        XCTAssertNil(bundle.fullVersionNumber)
    }
}

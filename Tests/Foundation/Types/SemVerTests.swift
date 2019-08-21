import XCTest
import Foundation
import MagicPills

class SemVerTests: XCTestCase {
    func test_initializers() {
        let versionFromString = Semver("1.2.3")
        XCTAssertEqual(versionFromString.major, 1)
        XCTAssertEqual(versionFromString.minor, 2)
        XCTAssertEqual(versionFromString.patch, 3)

        let versionFromComponents = Semver(major: 1, minor: 2, patch: 3)
        XCTAssertEqual(versionFromComponents.major, 1)
        XCTAssertEqual(versionFromComponents.minor, 2)
        XCTAssertEqual(versionFromComponents.patch, 3)
    }

    func test_comparacions() {
        XCTAssertTrue(Semver("1.2.3") > Semver("1.2.2"))
        XCTAssertTrue(Semver("1.2.3") > Semver("1.1.3"))
        XCTAssertTrue(Semver("1.2.3") > Semver("0.2.3"))
    }

    func test_equality() {
        XCTAssertEqual(Semver("J"), Semver("0.0.0"))
        XCTAssertEqual(Semver("2"), Semver("2.0.0"))
        XCTAssertEqual(Semver("2.3"), Semver("2.3.0"))
        XCTAssertEqual(Semver("1.2.3"), Semver("1.2.3"))
        XCTAssertNotEqual(Semver("1.0.3"), Semver("1.2.3"))
        XCTAssertNotEqual(Semver("0.0.3"), Semver("1.0.3"))
        XCTAssertNotEqual(Semver("0.0.0"), Semver("1.1.1"))
    }

    func test_description() {
        let version = Semver("1.2.3")
        XCTAssertEqual(version.description, "v1.2.3")
    }
}

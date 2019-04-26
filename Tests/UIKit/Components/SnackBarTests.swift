import XCTest
import Foundation
import MagicPills

class SnackBarTests: XCTestCase {

    func test_show_snackbar() {
        let completed = expectation(description: "Toast succesfully showed")
        let viewController = UIViewController()

        let message = "test snackbar"
        let snackBar = SnackBar.show(message: message, in: viewController.view, completion: completed.fulfill)

        XCTAssertEqual(snackBar.message, message)
        XCTAssertEqual(snackBar.frame.size.height, 80)
        waitForExpectations(timeout: 10)
    }

    func test_encode_decode() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: false)
        let message = "hi buddy!"
        let font = UIFont.boldSystemFont(ofSize: 23)
        let frame = CGRect(x: 0, y: 0, width: 20, height: 20)

        let snackbar = SnackBar(message, font: font, frame: frame)
        snackbar.encode(with: archiver)

        let unarchiver = NSKeyedUnarchiver(forReadingWith: archiver.encodedData)
        let recoveredSnackbar = SnackBar(coder: unarchiver)

        XCTAssertEqual(recoveredSnackbar?.message, message)
        XCTAssertEqual(recoveredSnackbar?.messageFont, font)
        XCTAssertEqual(recoveredSnackbar?.frame, frame)
    }

    func test_decode_without_data() {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: Data())
        let recoveredSnackbar = SnackBar(coder: unarchiver)

        XCTAssertNil(recoveredSnackbar)
    }
}

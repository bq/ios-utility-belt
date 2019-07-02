import XCTest
import Foundation
import MagicPills

class ToastTests: XCTestCase {
    func test_show_toast() {
        let completed = expectation(description: "Toast succesfully showed")
        let viewController = UIViewController()

        let message = "test toast"
        let toast = Toast.show(message: message, in: viewController.view, completion: completed.fulfill)

        XCTAssertEqual(toast.message, message)
        XCTAssertEqual(toast.frame.size.width, 150)

        waitForExpectations(timeout: 10)
    }

    func test_encode_decode() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: false)
        let message = "hi buddy!"
        let font = UIFont.boldSystemFont(ofSize: 23)
        let frame = CGRect(x: 0, y: 0, width: 20, height: 20)

        let toast = Toast(message, font: font, frame: frame)
        toast.encode(with: archiver)

        let unarchiver = NSKeyedUnarchiver(forReadingWith: archiver.encodedData)
        let recoveredToast = Toast(coder: unarchiver)

        XCTAssertEqual(recoveredToast?.message, message)
        XCTAssertEqual(recoveredToast?.messageFont, font)
        XCTAssertEqual(recoveredToast?.frame, frame)
    }

    func test_decode_without_data() {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: Data())
        let recoveredToast = Toast(coder: unarchiver)

        XCTAssertNil(recoveredToast)
    }
}

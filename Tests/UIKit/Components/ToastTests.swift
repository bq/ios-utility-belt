import XCTest
import Foundation
import MagicPills

class ToastTests: XCTestCase {

    func test_show_toast() {
        let viewController = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        let message = "test toast"
        let toast = Toast.showMessage(message, in: viewController.view)

        XCTAssertEqual(toast.message, message)
        XCTAssertEqual(toast.frame.size.width, 150)
    }
}

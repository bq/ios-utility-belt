import XCTest
import Foundation
import MagicPills

class SnackBarTests: XCTestCase {

    func test_show_snackbar() {
        let viewController = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        let message = "test snackbar"
        let snackBar = SnackBar.showMessage(message, in: viewController.view)

        XCTAssertEqual(snackBar.message, message)
        XCTAssertEqual(snackBar.frame.size.height, 80)
    }
}

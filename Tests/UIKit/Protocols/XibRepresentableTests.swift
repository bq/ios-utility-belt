import XCTest
import Foundation
import MagicPills

class XibRepresentableTests: XCTestCase {
    func test_xib_name() {
        XCTAssertEqual(ViewWithRepresentableXib.xibName, "ViewWithRepresentableXib")
    }
}

private class ViewWithRepresentableXib: UIView, XibRepresentable { }

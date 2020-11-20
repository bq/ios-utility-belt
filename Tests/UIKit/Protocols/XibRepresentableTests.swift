import XCTest
import Foundation
import MasMagicPills

class XibRepresentableTests: XCTestCase {
    func test_xib_name() {
        XCTAssertEqual(ViewWithRepresentableXib.xibName, "ViewWithRepresentableXib")
    }
}

private class ViewWithRepresentableXib: UIView { }

import XCTest
import UIKit
@testable import MagicPills

final class UIScrollViewExtensionsTests: XCTestCase {

    var scrollView: UIScrollView!
    let screenWidth: CGFloat = 828
    let screenHeight: CGFloat = 1_792
    let scrollHeight: CGFloat = 2_000

    override func setUp() {
        super.setUp()
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: screenWidth, height: screenHeight))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: screenWidth, height: scrollHeight)
    }

    func test_scroll_to_bottom() {
        let bottomOffset = CGPoint(x: 0,
                                   y: scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
        scrollView.scrollToBottom()
        XCTAssertEqual(bottomOffset, scrollView.contentOffset)
    }

    func test_scroll_to_top() {
        let bottomOffset = CGPoint(x: 0,
                                   y: scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
        scrollView.scrollToBottom()
        XCTAssertEqual(bottomOffset, scrollView.contentOffset)
        scrollView.scrollToTop()
        XCTAssertEqual(CGPoint.zero, scrollView.contentOffset)
    }
}

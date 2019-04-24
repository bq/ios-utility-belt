import XCTest
import UIKit
import MagicPills

final class UIScrollViewExtensionsTests: XCTestCase {

    let screenWidth: CGFloat = 828
    let screenHeight: CGFloat = 1_792
    let scrollHeight: CGFloat = 2_000

    func test_scroll_to_bottom() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: scrollHeight)

        let bottomOffset = CGPoint(x: 0,
                                   y: scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
        scrollView.scrollToBottom()
        XCTAssertEqual(bottomOffset, scrollView.contentOffset)
    }

    func test_scroll_to_top() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: scrollHeight)

        let bottomOffset = CGPoint(x: 0,
                                   y: scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
        scrollView.scrollToBottom()
        XCTAssertEqual(bottomOffset, scrollView.contentOffset)
        scrollView.scrollToTop()
        XCTAssertEqual(CGPoint.zero, scrollView.contentOffset)
    }

    func test_scroll_to_view() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: scrollHeight)

        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        let view2 = UIView(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: scrollHeight - screenHeight))
        scrollView.addSubviews([view1, view2])

        XCTAssertEqual(scrollView.contentOffset, CGPoint.zero)
        scrollView.scrollToView(view: view2)
        XCTAssertEqual(scrollView.contentOffset, CGPoint(x: 0, y: scrollHeight - screenHeight))
    }
}

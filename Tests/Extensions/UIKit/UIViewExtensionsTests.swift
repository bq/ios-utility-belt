import XCTest
import UIKit
import MagicPills

final class UIViewExtensionsTests: XCTestCase {

    func testBorderColor() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.borderColor = nil
        XCTAssertNil(view.borderColor)
        view.borderColor = UIColor.blue
        XCTAssertNotNil(view.layer.borderColor)
        XCTAssertEqual(view.borderColor, UIColor.blue)
        XCTAssertEqual(view.layer.borderColor, UIColor.blue.cgColor)
    }

    func testBorderWidth() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.borderWidth = 1
        XCTAssertEqual(view.layer.borderWidth, 1)

        view.borderWidth = 0
        XCTAssertEqual(view.borderWidth, 0)
    }

    func testCornerRadius() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertEqual(view.layer.cornerRadius, 0)

        view.cornerRadius = 20
        XCTAssertEqual(view.cornerRadius, 20)
    }

    func test_init_from_nib() {
        let cell: UICollectionViewCell? = .fromNib(bundle: Bundle(for: UIViewExtensionsTests.self))
        XCTAssertNotNil(cell)
    }

    func test_add_subviews() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertEqual(view.subviews.count, 0)

        view.addSubviews([UIView(), UIView()])
        XCTAssertEqual(view.subviews.count, 2)
    }

    func test_remove_subviews() {
        let view = UIView()
        view.addSubviews([UIView(), UIView()])
        view.removeSubviews()
        XCTAssertEqual(view.subviews.count, 0)
    }

    func test_shadow_color() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        var color: UIColor = .red
        view.layer.shadowColor = color.cgColor
        XCTAssertEqual(view.shadowColor, color)
        color = .blue
        view.shadowColor = color
        XCTAssertEqual(view.layer.shadowColor, color.cgColor)
    }

    func test_shadow_offset() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        var offset = CGSize(width: 2, height: 2)
        view.layer.shadowOffset = offset
        XCTAssertEqual(view.shadowOffset, offset)
        offset = CGSize(width: 7, height: 7)
        view.shadowOffset = offset
        XCTAssertEqual(view.layer.shadowOffset, offset)
    }

    func test_shadow_opacity() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.layer.shadowOpacity = 1
        XCTAssertEqual(view.shadowOpacity, 1)
        view.shadowOpacity = 0.5
        XCTAssertEqual(view.layer.shadowOpacity, 0.5)
    }

    func test_shadow_radius() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.layer.shadowRadius = 5
        XCTAssertEqual(view.shadowRadius, 5)
        view.shadowRadius = 0.75
        XCTAssertEqual(view.layer.shadowRadius, 0.75)
    }

    func test_add_shadow() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.addShadow()
        XCTAssertEqual(view.shadowColor, UIColor.black)
        XCTAssertEqual(view.shadowRadius, 1)
        XCTAssertEqual(view.shadowOffset, CGSize(width: 1, height: 1))
        XCTAssertEqual(view.shadowOpacity, 0.5)
    }

    func test_remove_shadow() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.addShadow()
        XCTAssertEqual(view.shadowColor, UIColor.black)
        XCTAssertEqual(view.shadowRadius, 1)
        XCTAssertEqual(view.shadowOffset, CGSize(width: 1, height: 1))
        XCTAssertEqual(view.shadowOpacity, 0.5)
        view.removeShadow()
        XCTAssertEqual(view.shadowColor, UIColor.clear)
        XCTAssertEqual(view.shadowRadius, 0)
        XCTAssertEqual(view.shadowOffset, CGSize(width: 0, height: 0))
        XCTAssertEqual(view.shadowOpacity, 0)
    }

    func test_show_and_hide() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.hide()
        XCTAssertEqual(view.isHidden, true)
        view.show()
        XCTAssertEqual(view.isHidden, false)
        view.hide(isAnimated: true)
        XCTAssertEqual(view.isHidden, true)
        view.show(isAnimated: true)
        XCTAssertEqual(view.isHidden, false)
    }

    func test_rotate_by_angle() {
        var angle: CGFloat = 0
        var angleInRadians: CGFloat {
            return angle * .pi / 180
        }

        let view1 = UIView()
        angle = 90
        let transform1 = CGAffineTransform(rotationAngle: angleInRadians)
        view1.rotate(angle)
        XCTAssertEqual(view1.transform, transform1)

        let view2 = UIView()
        angle = 45
        let transform2 = CGAffineTransform(rotationAngle: angleInRadians)
        view2.rotate(angle, animated: false, duration: 0, completion: nil)
        XCTAssertEqual(view2.transform, transform2)
    }
}

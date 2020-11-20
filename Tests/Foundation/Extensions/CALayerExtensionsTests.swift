import XCTest
import Foundation
import MasMagicPills
import UIKit

class CALayerExtensionsTests: XCTestCase {

    func test_round_sublayer() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        let dummySubLayer = CALayer()

        dummySubLayer.frame = view.layer.bounds
        view.layer.insertSublayer(dummySubLayer, at: 0)

        view.layer.roundSublayers(20)
        XCTAssertEqual(view.layer.sublayers?.first!.cornerRadius, 20)
    }

    func test_unround_sublayer() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        let dummySubLayer = CALayer()

        dummySubLayer.frame = view.layer.bounds
        view.layer.insertSublayer(dummySubLayer, at: 0)

        view.layer.roundSublayers(20)
        XCTAssertEqual(view.layer.sublayers?.first!.cornerRadius, 20)
        view.layer.unroundSublayers()
        XCTAssertEqual(view.layer.sublayers?.first!.cornerRadius, 0)
    }
}

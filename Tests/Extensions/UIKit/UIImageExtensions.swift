import XCTest
import Foundation
@testable import MagicPills

class UIImageExtensionsTests: XCTestCase {

    func test_colored_image() {
        let image = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        let image2 = UIImage(color: .yellow, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(image.colored(.yellow)?.bytesSize, image2.bytesSize)

        var emptyImage = UIImage()
        var coloredImage = emptyImage.colored(.red)
        XCTAssertEqual(emptyImage, coloredImage)

        emptyImage = UIImage(color: .yellow, size: CGSize.zero)
        coloredImage = emptyImage.colored(.red)
        XCTAssertEqual(emptyImage, coloredImage)
    }

    func test_tinted_image() {
        let baseImage = UIImage(color: .white, size: CGSize(width: 20, height: 20))
        let tintedImage = baseImage.tint(.black)
        let testImage = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(testImage.bytesSize, tintedImage?.bytesSize)
    }

}

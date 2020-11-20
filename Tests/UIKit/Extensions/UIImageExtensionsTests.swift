import XCTest
import Foundation
import MasMagicPills

class UIImageExtensionsTests: XCTestCase {

    func test_colored_image() {
        let image = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        let image2 = UIImage(color: .yellow, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(image.colored(.yellow)?.pngData(), image2.pngData())

        var emptyImage = UIImage()
        XCTAssertNil(emptyImage.colored(.red))

        emptyImage = UIImage(color: .yellow, size: CGSize.zero)
        XCTAssertNil(emptyImage.colored(.red))
    }

    func test_colored_image_from_ciimage() {
        let uiimageBlack = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        let ciimageBlack = CIImage(image: uiimageBlack)!

        XCTAssertNil(ciimageBlack.uiImage.colored(.red))
    }

    func test_tinted_image() {
        let baseImage = UIImage(color: .white, size: CGSize(width: 20, height: 20))
        let tintedImage = baseImage.tinted(.black)
        let testImage = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(testImage.pngData(), tintedImage?.pngData())
    }

    func test_tinted_image_with_image_of_zero_size() {
        let zeroSizeImage = UIImage(color: .white, size: CGSize.zero)
        XCTAssertNil(zeroSizeImage.tinted(.red))
    }

    func test_tinted_image_from_ciimage() {
        let uiimageBlack = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        let ciimageBlack = CIImage(image: uiimageBlack)!

        XCTAssertNil(ciimageBlack.uiImage.tinted(.red))
    }
}

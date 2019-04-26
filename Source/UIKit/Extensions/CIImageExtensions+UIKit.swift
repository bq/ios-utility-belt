import Foundation

public extension CIImage {
    var uiImage: UIImage {
        return UIImage(ciImage: self)
    }
}

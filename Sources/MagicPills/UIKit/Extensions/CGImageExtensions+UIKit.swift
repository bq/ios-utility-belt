import Foundation

public extension CGImage {
    var uiImage: UIImage {
        return UIImage(cgImage: self)
    }
}

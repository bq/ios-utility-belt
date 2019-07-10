#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

public extension CGImage {
    var uiImage: UIImage {
        return UIImage(cgImage: self)
    }
}
#endif

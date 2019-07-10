#if os(iOS) || os(tvOS)
import UIKit

public extension CIImage {
    var uiImage: UIImage {
        return UIImage(ciImage: self)
    }
}
#endif

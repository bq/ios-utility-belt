import UIKit

public extension UIImage {

    // MARK: - Methods

    /// Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)

        defer {
            UIGraphicsEndImageContext()
        }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }

        self.init(cgImage: cgImage)
    }

    /// Create image colored
    ///
    /// - Parameter color: color to fill
    /// - Returns: image colored with new color
    func colored(_ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        defer {
            UIGraphicsEndImageContext()
        }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = cgImage else {
            return nil
        }
        context.clip(to: rect, mask: mask)
        context.fill(rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /// Put tinted mask over image
    ///
    /// - Parameter color: color for tint mask
    /// - Returns: image with tinted mask
    func tinted(_ color: UIColor) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        guard
            let context = CGContext(data: nil,
                                    width: Int(width),
                                    height: Int(height),
                                    bitsPerComponent: 8,
                                    bytesPerRow: 0,
                                    space: colorSpace,
                                    bitmapInfo: bitmapInfo.rawValue),
            let maskImage = cgImage else {
                return nil
        }

        context.clip(to: bounds,
                     mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        return context.makeImage()?.uiImage
    }
}

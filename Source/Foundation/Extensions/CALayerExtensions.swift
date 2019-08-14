import Foundation

public extension CALayer {
    func roundSublayers(_ cornerRadius: CGFloat) {
        sublayers?
            .filter { $0.frame.equalTo(self.bounds) }
            .forEach {
                $0.cornerRadius = cornerRadius
                $0.roundSublayers(cornerRadius)
            }
        if let contents = self.contents {
            masksToBounds = false
            self.contents = nil
            if let sublayer = sublayers?.first,
                sublayer.name == "Constants.contentLayerName" {
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = "Constants.contentLayerName"
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }

    func unroundSublayers() {
        masksToBounds = true
        sublayers?
            .filter { $0.frame.equalTo(self.bounds) }
            .forEach {
                $0.cornerRadius = 0
                $0.unroundSublayers()
            }

        if let sublayer = sublayers?.first,
            sublayer.name == "Constants.contentLayerName" {
            self.contents = sublayer.contents
            sublayer.removeFromSuperlayer()
        }
    }
}

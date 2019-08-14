import UIKit

public extension UIView {

    // MARK: - Variables

    /// Border color
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }

            layer.borderColor = color.cgColor
        }
    }

    /// Border width
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// Corner radius
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    /// Shadow color of view
    var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    /// Shadow offset of view
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    /// Shadow opacity of view
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /// Shadow radius of view
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    // MARK: - Methods

    /// Load view from nib.
    ///
    /// - Returns: optional UIView (if applicable).
    class func fromNib<T: UIView>(bundle: Bundle = .main) -> T? {
        return bundle.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?[0] as? T
    }

    /// Add array of subviews
    ///
    /// - Parameter subviews: array of subviews to add to self
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }

    /// Remove all subviews in view.
    func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }

    /// Add custom shadow
    ///
    /// - Parameters:
    ///   - color: shadow color (default is black)
    ///   - opacity: shadow opacity (default is 0.2)
    ///   - offSet: shadow offset (default is 0 ; 2)
    ///   - radius: shadow radius (default is 2)
    func addShadow(color: UIColor = .black,
                   opacity: Float = 0.2,
                   offSet: CGSize = CGSize(width: 1, height: 1),
                   radius: CGFloat = 2) {

        layer.masksToBounds = false
        layer.shadowOffset = opacity.isZero ? CGSize(width: 0.0, height: 0.0) : offSet
        layer.shadowOpacity = opacity
        layer.shadowRadius = opacity.isZero ? 0.0 : radius
        layer.shadowColor = opacity.isZero ? UIColor.clear.cgColor : color.cgColor
        if cornerRadius != 0 {
            layer.roundSublayers(cornerRadius)
        }
    }

    /// Remove custom shadow
    func removeShadow() {
        layer.masksToBounds = true
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
        layer.shadowColor = UIColor.clear.cgColor
        layer.unroundSublayers()
    }

    /// Animate opacity of custom shadow
    ///
    /// - Parameters:
    ///   - value: opacity value
    ///   - duration: duration animation
    func animateShadowOpacity(to value: Float,
                              withDuration duration: CFTimeInterval) {
        let shadowAnimation = CABasicAnimation(keyPath: NSExpression(forKeyPath: \CALayer.shadowOpacity).keyPath)
        shadowAnimation.fromValue = shadowOpacity
        shadowAnimation.toValue = value
        shadowAnimation.duration = duration
        shadowAnimation.fillMode = CAMediaTimingFillMode.forwards
        shadowAnimation.isRemovedOnCompletion = false
        layer.add(shadowAnimation, forKey: nil)
    }

    /// Show view with animation
    ///
    /// - Parameter isAnimated: with animation (default is true)
    func show(isAnimated: Bool = true) {
        if self.isHidden {
            isAnimated ? changeAnimatedHiddenStatus() : (self.isHidden = false)
        }
    }

    /// Hide view with animation
    ///
    /// - Parameter isAnimated: with animation (default is true)
    func hide(isAnimated: Bool = true) {
        if !self.isHidden {
            isAnimated ? changeAnimatedHiddenStatus() : (self.isHidden = true)
        }
    }

    /// Rotate view by angle in degrees
    ///
    /// - Parameters:
    ///   - angle: angle in degrees to rotate view by.
    ///   - animated: set true to animate rotation (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func rotate(_ angle: CGFloat,
                animated: Bool = false,
                duration: TimeInterval = 1,
                completion: ((Bool) -> Void)? = nil) {

        let angleInRadians = .pi * angle / 180.0
        UIView.animate(withDuration: animated ? duration : 0,
                       delay: 0,
                       options: .curveLinear,
                       animations: { () -> Void in

            self.transform = self.transform.rotated(by: angleInRadians)
        }, completion: completion)
    }

    // MARK: - Private Methods

    private func changeAnimatedHiddenStatus() {
        UIView.animate(withDuration: 0.1) {
            self.isHidden = !self.isHidden
        }
    }
}

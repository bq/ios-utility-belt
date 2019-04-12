import UIKit

public extension UILabel {

    /// Set highlight text included in label text if is aplicable
    ///
    /// - Parameters:
    ///   - text: Text to hightlight
    ///   - color: Color to use in highlight text
    func highlight(_ text: String,
                   color: UIColor? = nil) {
        guard let baseText = self.text,
            let boldedText = baseText.bold(text,
                                       font: self.font,
                                       boldColor: color ?? self.textColor) else {
                                        return
        }

        self.attributedText = boldedText
    }
}

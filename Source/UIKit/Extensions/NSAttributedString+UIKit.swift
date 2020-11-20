import UIKit

public extension NSAttributedString {
    func bolding(_ sentence: String) -> NSAttributedString {
        guard
            let linkRange = self.string.nsRange(of: sentence),
            let currentFont = self.attribute(.font, at: 0, longestEffectiveRange: nil, in: linkRange) as? UIFont,
            let currentFoldBold = currentFont.bold
        else {
            return self
        }

        let attrString = NSMutableAttributedString(attributedString: self)
        attrString.removeAttribute(.font, range: linkRange)
        attrString.addAttributes([.font: currentFoldBold], range: linkRange)
        return attrString
    }

    func resizing(_ sentence: String, size: CGFloat) -> NSAttributedString {
        guard
            let linkRange = self.string.nsRange(of: sentence),
            let currentFont = self.attribute(.font, at: 0, longestEffectiveRange: nil, in: linkRange) as? UIFont
        else { return self }

        let attrString = NSMutableAttributedString(attributedString: self)
        attrString.removeAttribute(.font, range: linkRange)
        attrString.addAttributes([.font: currentFont.withSize(size)], range: linkRange)
        return attrString
    }

    func coloring(_ sentence: String, color: UIColor) -> NSAttributedString {
        guard
            let linkRange = self.string.nsRange(of: sentence)
        else { return self }

        let attrString = NSMutableAttributedString(attributedString: self)
        attrString.removeAttribute(.foregroundColor, range: linkRange)
        attrString.addAttributes([.foregroundColor: color], range: linkRange)
        return attrString
    }

    func customizing(_ sentence: String, size: CGFloat? = nil, color: UIColor? = nil, bold: Bool = false) -> NSAttributedString {
        var attrString = self
        if let size = size {
            attrString = attrString.resizing(sentence, size: size)
        }
        if let color = color {
            attrString = attrString.coloring(sentence, color: color)
        }
        if bold {
            attrString = attrString.bolding(sentence)
        }
        return attrString
    }
    func asUILabel() -> UILabel {
        let label = UILabel()
        label.attributedText = NSAttributedString(attributedString: self)
        return label
    }
}

import UIKit

public extension String {

    /// Add multiples attributes
    ///
    /// - Parameters:
    ///   - alignment: Alignment of the text
    ///   - lineHeight: Line space + font height (CSS Line Height)
    ///   - lineSpace: Line space value
    ///   - paragraphSpace: Paragraph space value
    ///   - letterSpacing: Space between characters
    ///   - font: Font to use
    ///   - color: Color to use
    /// - Returns: Attributed string
    func attributed(alignment: NSTextAlignment? = nil,
                    lineHeight: CGFloat? = nil,
                    lineSpace: CGFloat? = nil,
                    paragraphSpace: CGFloat? = nil,
                    letterSpacing: CGFloat? = nil,
                    font: UIFont,
                    color: UIColor? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()

        if let alignment = alignment {
            style.alignment = alignment
        }

        if let lineHeight = lineHeight {
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
        }

        if let lineSpace = lineSpace {
            style.lineSpacing = lineSpace
        }

        if let paragraphSpace = paragraphSpace {
            style.paragraphSpacing = paragraphSpace
        }

        attributedString.addAttribute(.paragraphStyle,
                                      value: style,
                                      range: NSRange(location: 0, length: self.count))

        if let letterSpacing = letterSpacing {
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: letterSpacing,
                                          range: NSRange(location: 0, length: self.count))
        }

        if let color = color {
            attributedString.addAttribute(.foregroundColor,
                                          value: color,
                                          range: NSRange(location: 0, length: self.count))
        }

        attributedString.addAttribute(.font,
                                      value: font,
                                      range: NSRange(location: 0, length: self.count))

        return attributedString
    }

    /// Add specific font attribute to last # characters
    ///
    /// - Parameters:
    ///   - characters: Number of last characters to change
    ///   - font: Font to set of this last characters
    ///   - defaultFont: Font to set to the rest of characters (optional)
    /// - Returns: String with last characters indicated with custom font attribute (optional)
    func attributed(lastCharacters quantity: Int, font: UIFont, defaultFont: UIFont? = nil) -> NSAttributedString {
        var stringAttributed = NSMutableAttributedString(string: self)

        if let defaultFont = defaultFont {
            stringAttributed = NSMutableAttributedString(string: self,
                                                         attributes: [.font: defaultFont])
        }

        if self.count >= quantity {
            let startIndex = self.index(self.endIndex, offsetBy: -(quantity))
            let substring = self[startIndex..<self.endIndex]
            let range = (self as NSString).range(of: String(substring))
            stringAttributed.addAttributes([.font: font], range: range)
        } else {
            stringAttributed.addAttributes([.font: font], range: NSRange(location: 0, length: self.count))
        }
        return stringAttributed
    }

    /// Bold text included in other text
    ///
    /// - Parameters:
    ///   - text: Text to bold
    ///   - font: Font to use
    ///   - boldColor: Color for bolded text
    /// - Returns: Attributed string with text indicated in bold (if founded)
    func bold(_ text: String,
              font: UIFont,
              boldColor: UIColor? = nil) -> NSAttributedString {
        let attr = NSMutableAttributedString(string: self)

        guard let boldRange = self.firstRangeOcurrence(text), let boldFont = font.bold else {
            return attr
        }

        if let boldColor = boldColor {
            attr.addAttributes([.font: boldFont, .foregroundColor: boldColor], range: boldRange)
        } else {
            attr.addAttributes([.font: boldFont], range: boldRange)
        }
        return attr
    }
}

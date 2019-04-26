import UIKit

public extension String {

    /// Add specific font attribute to last # characters
    ///
    /// - Parameters:
    ///   - characters: Number of last characters to change
    ///   - font: Font to set of this last characters
    /// - Returns: String with last characters indicated with custom font attribute (optional)
    func attributed(lastCharacters quantity: Int, font: UIFont) -> NSAttributedString {
        let stringAttributed = NSMutableAttributedString(string: self)
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

    /// Add multiples attributes
    ///
    /// - Parameters:
    ///   - lineSpace: Line space value
    ///   - paragraphSpace: Paragraph space value
    ///   - font: Font to use
    /// - Returns: Attributed string (optional)
    func attributed(lineSpace: CGFloat? = nil,
                    paragraphSpace: CGFloat? = nil,
                    font: UIFont? = nil) -> NSAttributedString {
        let descriptionAttributedString = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()
        if let lineSpace = lineSpace {
            style.lineSpacing = lineSpace
        }
        if let paragraphSpace = paragraphSpace {
            style.paragraphSpacing = paragraphSpace
        }
        descriptionAttributedString.addAttribute(.paragraphStyle,
                                                 value: style,
                                                 range: NSRange(location: 0, length: self.count))
        if let font = font {
            descriptionAttributedString.addAttribute(.font,
                                                     value: font,
                                                     range: NSRange(location: 0, length: self.count))
        }

        return descriptionAttributedString
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

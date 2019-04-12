import UIKit

public extension String {

    /// Add specific font attribute to last # characters
    ///
    /// - Parameters:
    ///   - characters: Number of last characters to change
    ///   - font: Font to set of this last characters
    /// - Returns: String with last characters indicated with custom font attribute (optional)
    func attributeLastCharacters(_ quantity: Int, font: UIFont) -> NSAttributedString {
        let stringAttributed = NSMutableAttributedString(string: self)
        if self.count >= quantity {
            let startIndex = self.index(self.endIndex, offsetBy: -(quantity))
            let substring = self[startIndex..<self.endIndex]
            let range = (self as NSString).range(of: String(substring))
            let attribute = [NSAttributedString.Key.font: font]
            stringAttributed.addAttributes(attribute, range: range)
        } else {
            let attribute = [NSAttributedString.Key.font: font]
            stringAttributed.addAttributes(attribute, range: NSRange(location: 0, length: self.count))
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
    func attribute(lineSpace: CGFloat? = nil,
                   paragraphSpace: CGFloat? = nil,
                   font: UIFont? = nil) -> NSAttributedString? {
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
    /// - Returns: Attributed string with text indicated in bold (optional)
    func bold(_ text: String,
              font: UIFont,
              boldColor: UIColor? = nil) -> NSAttributedString? {
        guard let boldRange = self.firstRangeOcurrence(text), let boldFont = font.bold else {
            return nil
        }

        let attributedString = NSMutableAttributedString(string: self)
        var attributes: [NSAttributedString.Key: Any] = [:]

        if let boldColor = boldColor {
            attributes = [.foregroundColor: boldColor,
                          .font: boldFont]
        } else {
            attributes = [.font: boldFont]
        }

        attributedString
            .addAttributes(attributes,
                           range: boldRange)
        return attributedString
    }
}

public extension StringProtocol where Index == String.Index {

    /// Look for where is the first text occurence in string
    ///
    /// - Parameters:
    ///   - text: Text to look for
    ///   - options: Options to compare
    ///   - range: Range of string where look for
    ///   - locale: Information for use in formatting data for presentation
    /// - Returns: Range for the first text occurence in string (optional)
    func firstRangeOcurrence(_ text: Self,
                             options: String.CompareOptions = [],
                             range: Range<Index>? = nil,
                             locale: Locale? = nil) -> NSRange? {

        guard let range = self.range(of: text,
                                     options: options,
                                     range: range ?? startIndex..<endIndex,
                                     locale: locale ?? .current) else { return nil }
        return NSRange(range, in: self)
    }

    /// Look Ranges of texts occurrences inn all string
    ///
    /// - Parameters:
    ///   - text: Text to look for
    ///   - options: Options to compare
    ///   - range: Range of string where look for
    ///   - locale: Information for use in formatting data for presentation
    /// - Returns: Ranges of texts occurrences in all string (if not find any, return empty array)
    func rangesOcurrences(_ text: Self,
                          options: String.CompareOptions = [],
                          range: Range<Index>? = nil,
                          locale: Locale? = nil) -> [NSRange] {

        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end, let range = self.range(of: text,
                                                  options: options,
                                                  range: start..<end,
                                                  locale: locale ?? .current) {
                                                    ranges.append(NSRange(range, in: self))
                                                    start = range.upperBound
        }
        return ranges
    }
}

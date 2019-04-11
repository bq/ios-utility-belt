import Foundation
import UIKit

public extension String {
    func attributed(lineSpace: CGFloat? = nil,
                    paragraphSpace: CGFloat? = nil,
                    font: UIFont? = nil) -> NSAttributedString {

        let attr = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()
        if let lineSpace = lineSpace {
            style.lineSpacing = lineSpace
        }
        if let paragraphSpace = paragraphSpace {
            style.paragraphSpacing = paragraphSpace
        }
        attr.addAttribute(.paragraphStyle,
                          value: style,
                          range: NSRange(location: 0, length: self.count))

        if let font = font {
            attr.addAttribute(.font,
                              value: font,
                              range: NSRange(location: 0, length: self.count))
        }

        return attr
    }

    func attributedLink(_ link: String,
                        bodyTextColor: UIColor = .white,
                        bodyTextFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize),
                        linkTextColor: UIColor = .white,
                        linkTextFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)) -> NSMutableAttributedString {

        let attr = NSMutableAttributedString(string: self)
        attr.addAttributes([.foregroundColor: bodyTextColor, .font: bodyTextFont], range: bodyRange)

        if let linkRange = self.nsRange(of: link) {
            attr.addAttributes([.foregroundColor: linkTextColor, .font: linkTextFont], range: linkRange)
        }

        return attr
    }

    func attributedLastCharacters(_ characters: Int,
                                  font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)) -> NSAttributedString {

        var characters = characters
        if characters > count {
            characters = count
        }

        let attr = NSMutableAttributedString(string: self)
        let startIndex = index(endIndex, offsetBy: -(characters))
        let substring = self[startIndex..<endIndex]
        let range = (self as NSString).range(of: String(substring))
        attr.addAttributes([.font: font], range: range)
        return attr
    }
}

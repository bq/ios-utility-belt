import Foundation
import UIKit

public extension String {
//    func attributedLastCharacters(_ characters: Int, font: UIFont = UIFont.systemRegular(size: 16)) -> NSAttributedString? {
//
//        if self.count >= characters {
//            let stringAttributed = NSMutableAttributedString(string: self)
//            let startIndex = self.index(self.endIndex, offsetBy: -(characters))
//            let substring = self[startIndex..<self.endIndex]
//            let range = (self as NSString).range(of: String(substring))
//            let attribute = [NSAttributedString.Key.font: font]
//            stringAttributed.addAttributes(attribute, range: range)
//            return stringAttributed
//        } else {
//            return nil
//        }
//
//    }

    func attributed(lineSpace: CGFloat? = nil,
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

//    func attributedLink(_ link: String, bodyTextColor: UIColor? = .white, linkTextColor: UIColor? = .white) -> NSMutableAttributedString {
//        if let bodyRange = self.nsRange(of: self), let linkRange = self.nsRange(of: link) {
//            let attributedString = NSMutableAttributedString(string: self)
//            attributedString.addAttributes([.foregroundColor: bodyTextColor ?? .white], range: bodyRange)
//            attributedString.addAttributes([.foregroundColor: linkTextColor ?? .white,
//                                            .font: UIFont.systemBold(size: 14)], range: linkRange)
//            return attributedString
//        } else {
//            return NSMutableAttributedString(string: "")
//        }
//    }
}

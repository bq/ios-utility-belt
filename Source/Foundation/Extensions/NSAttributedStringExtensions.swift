import Foundation

public extension NSAttributedString {
    func uppercased() -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)

        result.enumerateAttributes(in: NSRange(location: 0, length: length), options: []) {_, range, _ in
            result.replaceCharacters(in: range, with: (string as NSString).substring(with: range).uppercased())
        }

        return result
    }

    func underlining(_ sentence: String) -> NSAttributedString {
        guard let linkRange = self.string.nsRange(of: sentence) else {
            return self
        }

        let attrString = NSMutableAttributedString(attributedString: self)
        attrString.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: linkRange)
        return attrString
    }
}

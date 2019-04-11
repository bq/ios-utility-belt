import Foundation

public extension String {
    var underLined: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.underlineStyle: 1])
    }

    var formattedAsPhoneNumber: String {
        var formatted = self
        if formatted.count > 3 {
            formatted.insert(" ", at: index(startIndex, offsetBy: 3))
        }
        if formatted.count > 7 {
            formatted.insert(" ", at: index(startIndex, offsetBy: 7))
        }
        return formatted
    }
}

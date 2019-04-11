import Foundation

public extension String {
    var isValidEmail: Bool {
        var emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")"
        emailRegEx += "@(?:(?:[a-z0-9](?:[a-" + "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.)"
        emailRegEx += "{3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    var isValidPhone: Bool {
        let phoneRegEx = "^[679][0-9]{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }

    var isValidNIF: Bool {
        let identifierBase = self.uppercased()
        if !identifierBase.isEmpty {
            guard let numberBase: Int = Int(identifierBase.prefix(self.count - 1)),
                let letter: Character = identifierBase.last else {
                    return false
            }
            let letterMap = "TRWAGMYFPDXBNJZSQVHLCKET"
            let letterIndex = numberBase % 23
            let letterPositionInMap = letterMap.index(of: letter)?.encodedOffset

            return letterPositionInMap == letterIndex ? true : false
        }
        return false
    }

    var isValidNIE: Bool {
        let identifierBase = self.uppercased()

        if isFormatValidNIE {
            let buffer = NSMutableString(string: self.uppercased())
            buffer.replaceOccurrences(of: "X", with: "0", options: .anchored, range: NSRange(location: 0, length: 1))
            buffer.replaceOccurrences(of: "Y", with: "1", options: .anchored, range: NSRange(location: 0, length: 1))
            buffer.replaceOccurrences(of: "Z", with: "2", options: .anchored, range: NSRange(location: 0, length: 1))
            guard let numberBase: Int = Int(buffer.standardizingPath.prefix(self.count - 1)), let letter: Character = identifierBase.last else {
                return false
            }
            let letterMap = "TRWAGMYFPDXBNJZSQVHLCKET"
            let letterIndex = numberBase % 23
            let letterPositionInMap = letterMap.index(of: letter)?.encodedOffset

            return letterPositionInMap == letterIndex ? true : false
        } else {
            return false
        }
    }

    private var isFormatValidNIE: Bool {
        let nieRegex = "[XYZ][0-9]{7}[0-9A-Z]"
        let regexPredicate = NSPredicate(format: "SELF MATCHES[c] %@", nieRegex)
        return regexPredicate.evaluate(with: self)
    }
}

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

        guard
            !identifierBase.isEmpty,
            let numberBase = Int(identifierBase.prefix(self.count - 1)),
            let letter = identifierBase.last else {
                return false
        }

        let letterMap = "TRWAGMYFPDXBNJZSQVHLCKET"
        let letterIndex = numberBase % 23
        let letterPositionInMap = letterMap.firstIndex(of: letter)?.utf16Offset(in: letterMap)

        return letterPositionInMap == letterIndex ? true : false
    }

    var isValidNIE: Bool {
        guard !self.isEmpty else {
            return false
        }

        var identifierBase = self.uppercased()
        let start = identifierBase.startIndex
        let end = identifierBase.index(identifierBase.startIndex, offsetBy: 1)
        identifierBase = identifierBase.replacingOccurrences(of: "X", with: "0", options: .anchored, range: start..<end)
        identifierBase = identifierBase.replacingOccurrences(of: "Y", with: "1", options: .anchored, range: start..<end)
        identifierBase = identifierBase.replacingOccurrences(of: "Z", with: "2", options: .anchored, range: start..<end)

        return identifierBase.isValidNIF
    }
}

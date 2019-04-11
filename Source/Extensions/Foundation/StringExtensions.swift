import Foundation

public extension String {
    var capitalizedFirstLetter: String {
        return prefix(1).uppercased() + dropFirst()
    }

    var capitalizedWords: String {
        return self.split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }

    var capitalizedSentences: String {
        return self.components(separatedBy: ". ")
            .map { String($0).capitalizedFirstLetter }
            .joined(separator: ". ")
    }

    var lowercasedLeastTheFirstUnchanged: String {
        return prefix(1) + dropFirst().lowercased()
    }

    var dataUTF8: Data {
        return data(using: String.Encoding.utf8)!
    }

    var removingWhiteSpaces: String {
        return components(separatedBy: .whitespaces).joined()
    }

    var base64decoded: String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    var base64encoded: String {
        return Data(self.utf8).base64EncodedString()
    }

    func localized(bundle: Bundle = .main, tableName: String = "Common") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }

    func match(withPattern pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let range = NSRange(location: 0, length: count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }

    func htmlValue(fontSize: Float, fontFamily: String? = nil) -> String {
        if let fontFamily = fontFamily {
            return "<span style=\"font-family: \(fontFamily); font-size: \(fontSize)\">\(self)</span>"
        }
        return "<span style=\"font-size: \(fontSize)\">\(self)</span>"
    }

    func satisfiesRegexp(_ regexp: String) -> Bool {
        return range(of: regexp, options: .regularExpression) != nil
    }

    /// Replaces the matches of the given regex pattern with an user-defined String.
    func replacingRegexMatches(of pattern: String, with replacing: String) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacing)
    }
}

extension StringProtocol where Index == String.Index {
    func nsRange(of string: Self, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> NSRange? {
        guard let range = self.range(of: string, options: options, range: range ?? startIndex..<endIndex, locale: locale ?? .current) else { return nil }
        return NSRange(range, in: self)
    }

    func nsRanges(of string: Self, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> [NSRange] {
        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end, let range = self.range(of: string, options: options, range: start..<end, locale: locale ?? .current) {
            ranges.append(NSRange(range, in: self))
            start = range.upperBound
        }
        return ranges
    }
}

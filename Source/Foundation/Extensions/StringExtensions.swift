import Foundation

public extension String {
    var addTrailingSpaceIfNotEmpty: String {
        return isEmpty ? "" : "\(self) "
    }

    var capitalizeWords: String {
        return self.split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }

    var capitalizeSentences: String {
        return self.components(separatedBy: ". ")
            .map { String($0).capitalizedFirstLetter }
            .joined(separator: ". ")
    }

    func starts(withAnyOf: [String]) -> Bool {
        return withAnyOf.contains { starts(with: $0) }
    }

    var capitalizedFirstLetter: String {
        if starts(withAnyOf: ["¡", "¿"]) {
            return prefix(2).uppercased() + dropFirst(2)
        }
        return prefix(1).uppercased() + dropFirst(1)
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

    var trimed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
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
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }

    func htmlValue(fontSize: Float, fontFamily: String? = nil) -> String {
        if let fontFamily = fontFamily {
            return "<span style=\"font-family: \(fontFamily); font-size: \(fontSize)\">\(self)</span>"
        }
        return "<span style=\"font-size: \(fontSize)\">\(self)</span>"
    }

    func satisfiesRegex(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression) != nil
    }

    /// Replaces the matches of the given regex pattern with an user-defined String.
    func replacingRegexMatches(of pattern: String, with replacing: String) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacing)
    }

    /// Look for where is the first text occurence in string
    ///
    /// - Parameters:
    ///   - text: Text to look for
    ///   - options: Options to compare
    ///   - range: Range of string where look for
    ///   - locale: Information for use in formatting data for presentation
    /// - Returns: Range for the first text occurence in string (optional)
    func firstRangeOcurrence(_ text: String,
                             options: String.CompareOptions = [],
                             range: Range<Index>? = nil,
                             locale: Locale? = nil) -> NSRange? {

        guard let range = self.range(of: text,
                                     options: options,
                                     range: range ?? startIndex..<endIndex,
                                     locale: locale ?? .current) else { return nil }
        return NSRange(range, in: self)
    }

    /// Look Ranges of texts occurrences in all string
    ///
    /// - Parameters:
    ///   - text: Text to look for
    ///   - options: Options to compare
    ///   - range: Range of string where look for
    ///   - locale: Information for use in formatting data for presentation
    /// - Returns: Ranges of texts occurrences in all string (if not find any, return empty array)
    func ocurrencesRanges(_ text: String,
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

    var bodyRange: NSRange {
        return nsRange(of: self)!
    }

    func nsRange(of string: String) -> NSRange? {
        guard let range = self.range(of: string, options: [], range: startIndex..<endIndex, locale: .current) else {
            return nil
        }
        return NSRange(range, in: self)
    }
}

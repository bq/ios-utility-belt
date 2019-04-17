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

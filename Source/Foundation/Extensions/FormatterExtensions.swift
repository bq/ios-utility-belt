public extension Formatter {

    /// Get DateFormatter with specific Locale and TimeZone
    ///
    /// - Parameters:
    ///   - locale: Specific Locale to Format (optional) (by default use current)
    ///   - timeZone: Specific Time Zone to format (optional) (by default use current)
    /// - Returns: DateFormatter with specific or current Locale and Time Zone
    static func date(locale: Locale? = nil,
                     timeZone: TimeZone? = nil) -> DateFormatter {
        let dateFormatter = DateFormatter()
        if let locale = locale { dateFormatter.locale = locale }
        if let timeZone = timeZone { dateFormatter.timeZone = timeZone }
        return dateFormatter
    }
}

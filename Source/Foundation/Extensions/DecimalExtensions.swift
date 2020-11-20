import Foundation

public extension Decimal {

    /// Convert milliseconds(self) to seconds
    var millisecondsToSeconds: Decimal {
        return self / 1_000
    }

    /// Convert milliseconds(self) to minutes
    var millisecondsToMinutes: Decimal {
        return self / 60_000
    }

    /// Convert seconds(self) to minutes
    var secondsToMinutes: Decimal {
        return self / 60
    }

    /// Convert given megas to Megabytes (1000 bytes) and format it with Locale and specific decimals
    ///
    /// - Parameters:
    ///   - locale: Language rules (optional) (by default use current)
    ///   - decimals: Number of decimals to use (optional) (by default use 0)
    /// - Returns: String with specified format
    func formattedMegabytes(_ locale: Locale? = nil,
                            decimals: Int = 0) -> String {
        if abs(self) >= 1_000 {
            return (self / 1_000).formatted(decimals: decimals,
                                            locale: locale,
                                            unit: .init(symbol: "GB"))
        }
        return formatted(decimals: 0,
                         locale: locale,
                         unit: .init(symbol: "MB"))
    }

    /// Convert given megas to Mebibytes (1024 bytes) and format it with Locale and specific decimals
    ///
    /// - Parameters:
    ///   - locale: Language rules (optional) (by default use current)
    ///   - decimals: Number of decimals to use (optional) (by default use 0)
    /// - Returns: String with specified format
    func formattedMebibytes(_ locale: Locale? = nil,
                            decimals: Int = 0) -> String {
        if abs(self) >= 1_000 {
            return (self / 1_024).formatted(decimals: decimals,
                                            locale: locale,
                                            unit: .init(symbol: "GiB"))
        }
        return formatted(decimals: 0,
                         locale: locale,
                         unit: .init(symbol: "MiB"))
    }

    /// Convert to Megabits (1000 bits) and format it with Locale and specific decimals
    ///
    /// - Parameters:
    ///   - locale: Language rules (optional) (by default use current)
    ///   - decimals: Number of decimals to use (optional) (by default use 0)
    /// - Returns: String with specified format
    func formattedMegabits(_ locale: Locale? = nil,
                           decimals: Int = 0) -> String {
        if abs(self) >= 1_000 {
            return (self / 1_000).formatted(decimals: decimals,
                                            locale: locale,
                                            unit: .init(symbol: "Gb"))
        }
        return formatted(decimals: 0,
                         locale: locale,
                         unit: .init(symbol: "Mb"))
    }

    /// Convert to string with specified parameters
    ///
    /// - Parameters:
    ///   - decimals: Number of decimals to use
    ///   - currencyCode: Three-letter code that denote the currency unit. For example, Australian dollar is “AUD”. Currency codes are based on the ISO 4217 standard.
    ///   - locale: Language rules to use
    ///   - numberStyle: Predefined number format style
    ///   - unit: Unit for Measurement format
    /// - Returns: String with specified format
    func formatted(decimals: Int = 2,
                   currencyCode: CurrencyCodeType? = nil,
                   locale: Locale? = nil,
                   numberStyle: NumberFormatter.Style? = nil,
                   unit: Unit = Unit(symbol: "")) -> String {
        let numberFormatter = NumberFormatter()

        if let currencyCode = currencyCode?.rawValue {
            numberFormatter.currencyCode = currencyCode
            numberFormatter.numberStyle = .currency
        }

        if let numberStyle = numberStyle {
            numberFormatter.numberStyle = numberStyle
        }

        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = decimals
        numberFormatter.maximumFractionDigits = decimals

        let formatter = MeasurementFormatter()

        if let locale = locale {
            formatter.locale = locale
            numberFormatter.locale = locale
        }

        formatter.numberFormatter = numberFormatter

        let measurement = Measurement(value: Double(truncating: self as NSNumber), unit: unit)
        return formatter.string(from: measurement).trimed
    }
}

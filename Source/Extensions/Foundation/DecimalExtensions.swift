import Foundation

public extension Decimal {
    var spanishFormattedMegabytesWithoutDecimals: String {
        if abs(self) >= 1_000 {
            return "\((self / 1_024).spanishFormatted(decimals: 0)) GB"
        }
        return "\(self.spanishFormatted(decimals: 0)) MB"
    }

    var spanishFormattedMegabytes: String {
        if abs(self) >= 1_000 {
            return "\((self / 1_024).spanishFormatted(decimals: 2)) GB"
        }
        return "\(self.spanishFormatted(decimals: 0)) MB"
    }

    var spanishFormattedMegabits: String {
        if abs(self) >= 1_000 {
            return "\((self / 1_000).spanishFormatted(decimals: 2)) Gb"
        }
        return "\(self.spanishFormatted(decimals: 0)) Mb"
    }

    func spanishFormattedCurrency(decimals: Int = 2, currencySymbol: String? = nil) -> String {
        let formatter = NumberFormatter.spanishCurrencyFormatter
        formatter.currencySymbol = currencySymbol ?? "€"
        formatter.minimumFractionDigits = decimals
        formatter.maximumFractionDigits = decimals
        return formatter.string(for: self)!
    }

    func spanishFormatted(decimals: Int = 2) -> String {
        let formatter = NumberFormatter.spanishDecimalFormatter
        formatter.minimumFractionDigits = decimals
        formatter.maximumFractionDigits = decimals
        return formatter.string(for: self)!
    }

    var milisecondsToSeconds: Decimal {
        return self / 1_000
    }

    var milisecondsToMinutes: Decimal {
        return self / 60_000
    }

    var secondsToMinutes: Decimal {
        return self / 60
    }
}

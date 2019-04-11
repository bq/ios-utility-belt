import Foundation

public extension NumberFormatter {
    static var spanishCurrencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.numberStyle = .currency
        return formatter
    }

    static var spanishDecimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.numberStyle = .decimal
        return formatter
    }
}

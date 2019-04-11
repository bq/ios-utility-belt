import XCTest
import Foundation
import MagicPills

class DecimalExtensionsTests: XCTestCase {
    func test_format_megabytes_in_spanish_format() {
        XCTAssertEqual((1_017 as Decimal).spanishFormattedMegabytes, "0,99 GB")
        XCTAssertEqual((1_024 as Decimal).spanishFormattedMegabytes, "1,00 GB")
        XCTAssertEqual((1_024 as Decimal).spanishFormattedMegabytesWithoutDecimals, "1 GB")
        XCTAssertEqual((900 as Decimal).spanishFormattedMegabytesWithoutDecimals, "900 MB")
        XCTAssertEqual((900 as Decimal).spanishFormattedMegabytes, "900 MB")
        XCTAssertEqual((0 as Decimal).spanishFormattedMegabytes, "0 MB")
        XCTAssertEqual((3_000 as Decimal).spanishFormattedMegabytes, "2,93 GB")
        XCTAssertEqual((3_000 as Decimal).spanishFormattedMegabytesWithoutDecimals, "3 GB")
        XCTAssertEqual((-3_000 as Decimal).spanishFormattedMegabytes, "-2,93 GB")
    }

    func test_format_megabit_in_spanish_format() {
        XCTAssertEqual((1_017 as Decimal).spanishFormattedMegabits, "1,02 Gb")
        XCTAssertEqual((1_024 as Decimal).spanishFormattedMegabits, "1,02 Gb")
        XCTAssertEqual((900 as Decimal).spanishFormattedMegabits, "900 Mb")
        XCTAssertEqual((0 as Decimal).spanishFormattedMegabits, "0 Mb")
        XCTAssertEqual((3_000 as Decimal).spanishFormattedMegabits, "3,00 Gb")
        XCTAssertEqual((-3_000 as Decimal).spanishFormattedMegabits, "-3,00 Gb")
    }

    func test_format_currency() {
        XCTAssertEqual((33 as Decimal).spanishFormattedCurrency(decimals: 2, currencySymbol: "$"), "33,00 $")
        XCTAssertEqual((1_345 as Decimal).spanishFormattedCurrency(decimals: 1), "1.345,0 €")
    }

    func test_convert_miliseconds_to_seconds() {
        XCTAssertEqual((10_000 as Decimal).milisecondsToSeconds, 10)
    }

    func test_convert_miliseconds_to_minutes() {
        let number: Decimal = 124_232
        XCTAssertEqual(number.milisecondsToMinutes, number.milisecondsToSeconds.secondsToMinutes)
    }

    func test_convert_seconds_to_minutes() {
        XCTAssertEqual((6_000 as Decimal).secondsToMinutes, 100)
    }
}

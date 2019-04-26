import XCTest
import Foundation
import MagicPills

class StringExtensionsTests: XCTestCase {
    func test_capitalized_first_letter() {
        XCTAssertEqual("Hola".capitalizedFirstLetter, "Hola")
        XCTAssertEqual("HOLA".capitalizedFirstLetter, "HOLA")
        XCTAssertEqual("hOLA".capitalizedFirstLetter, "HOLA")
    }

    func test_capitalized_words() {
        XCTAssertEqual("hola y chau".capitalizedWords, "Hola Y Chau")
    }

    func test_capitalized_sentences() {
        XCTAssertEqual("wawa. wewe we wi. wowo".capitalizedSentences, "Wawa. Wewe we wi. Wowo")
    }

    func test_lowercased_all_least_the_first_unchanged() {
        XCTAssertEqual("Hola".lowercasedLeastTheFirstUnchanged, "Hola")
        XCTAssertEqual("HOLA".lowercasedLeastTheFirstUnchanged, "Hola")
        XCTAssertEqual("hOLA".lowercasedLeastTheFirstUnchanged, "hola")
    }

    func test_utf8_convertion() {
        XCTAssertEqual("hola".dataUTF8.stringUTF8, "hola")
    }

    func test_removing_whitespaces() {
        XCTAssertEqual("hola que tal".removingWhiteSpaces, "holaquetal")
    }

    func test_base64_encode_and_decode() {
        XCTAssertEqual("hola".base64encoded.base64decoded, "hola")
        XCTAssertEqual("chau".base64encoded.base64decoded, "chau")
        XCTAssertEqual("😘".base64encoded.base64decoded, "😘")
        XCTAssertNil("bad base64 string".base64decoded)
    }

    func test_html_value() {
        let text1 = "hola"
        let text2 = "chau"
        let html1 = text1.htmlValue(fontSize: 12)
        let html2 = text2.htmlValue(fontSize: 14, fontFamily: "Arial")

        let attrString1 = try? NSAttributedString(data: html1.dataUTF8,
                                                  options: [.documentType: NSAttributedString.DocumentType.html],
                                                  documentAttributes: nil)
        let attrString2 = try? NSAttributedString(data: html2.dataUTF8,
                                                  options: [.documentType: NSAttributedString.DocumentType.html],
                                                  documentAttributes: nil)
        XCTAssertEqual(attrString1?.string, text1)
        XCTAssertTrue(html1.contains("font-size: 12"))

        XCTAssertEqual(attrString2?.string, text2)
        XCTAssertTrue(html2.contains("font-size: 14"))
        XCTAssertTrue(html2.contains("font-family: Arial"))
    }

    func test_satisfies_regex() {
        XCTAssertTrue("X1234567X".satisfiesRegex("[XYZ][0-9]{7}[0-9A-Z]"))
        XCTAssertTrue("X1234567X".satisfiesRegex("^[xyzXYZ]{1}[0-9]{7}[TRWAGMYFPDXBNJZSQVHLCKET]{1}$"))
    }

    func test_replacing_regex_matches() {
        XCTAssertEqual(try? "+851 124 124 124".replacingRegexMatches(of: "\\+[0-9]{1,3}\\ ", with: ""), "124 124 124")
        XCTAssertEqual(try? "+124 918918918".replacingRegexMatches(of: "\\+[0-9]{1,3}\\ ", with: "☎: "), "☎: 918918918")
    }

    func test_first_range_ocurrence() {
        let text = "hola chau"

        XCTAssertEqual(text.firstRangeOcurrence("hola"), NSRange(location: 0, length: 4))
        XCTAssertEqual(text.firstRangeOcurrence("chau"), NSRange(location: 5, length: 4))
        XCTAssertNil(text.firstRangeOcurrence("adios"))
    }

    func test_ocurrences_ranges() {
        let ocurrences = "hola hola, que tal?".ocurrencesRanges("hola")

        XCTAssertEqual(ocurrences, [NSRange(location: 0, length: 4), NSRange(location: 5, length: 4)])
    }

    func test_bodyRange() {
        XCTAssertEqual("hola".bodyRange, NSRange(location: 0, length: 4))
        XCTAssertEqual("ho".bodyRange, NSRange(location: 0, length: 2))
    }

    func test_nsRange_of_string() {
        XCTAssertNil("hola".nsRange(of: "chau"))
        XCTAssertEqual("hola".nsRange(of: "la"), NSRange(location: 2, length: 2))
    }

    func test_localized() {
        let bundle = Bundle(for: StringExtensionsTests.self)
        let tableName = "LocalizedSample"
        let localizedExample = NSLocalizedString("sample_text", tableName: tableName, bundle: bundle, comment: "")

        XCTAssertEqual(localizedExample, "Sample Text")
        XCTAssertEqual("sample_text".localized(bundle: bundle, tableName: tableName), localizedExample)
        XCTAssertEqual("not_found".localized(bundle: bundle, tableName: tableName), "**not_found**")
    }
}

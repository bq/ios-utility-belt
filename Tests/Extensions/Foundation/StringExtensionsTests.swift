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
}

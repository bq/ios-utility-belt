import XCTest
import Foundation
import MasMagicPills

class StringExtensionsValidatorsTests: XCTestCase {
    func test_valid_internet_url() {
        XCTAssertTrue("itms://itunes.apple.com/es/app/xxxx/id123132156465456456".isValidInternetUrl)
        XCTAssertTrue("http://www.google.com".isValidInternetUrl)
        XCTAssertFalse("wawawa".isValidInternetUrl)
        XCTAssertFalse("".isValidInternetUrl)
    }

    func test_is_valid_email() {
        XCTAssertTrue("wawa@wewe.com".isValidEmail)
        XCTAssertTrue("hola@bq.com".isValidEmail)
    }

    func test_is_not_valid_email() {
        XCTAssertFalse("chau".isValidEmail)
    }

    func test_is_valid_phone() {
        XCTAssertTrue("687687687".isValidPhone)
        XCTAssertTrue("787687687".isValidPhone)
        XCTAssertTrue("987687687".isValidPhone)
    }

    func test_is_not_valid_phone() {
        XCTAssertFalse("587687687".isValidPhone)
        XCTAssertFalse("124".isValidPhone)
        XCTAssertFalse("kkk".isValidPhone)
    }

    func test_is_valid_nif() {
        XCTAssertTrue("01234567L".isValidNIF)
        XCTAssertTrue("11234567X".isValidNIF)
        XCTAssertTrue("21234567R".isValidNIF)
        XCTAssertTrue("12345678Z".isValidNIF)
        XCTAssertTrue("05446767E".isValidNIF)
    }

    func test_is_not_valid_nif() {
        XCTAssertFalse("05446767F".isValidNIF)
        XCTAssertFalse("kkk".isValidNIF)
        XCTAssertFalse("".isValidNIF)
    }

    func test_is_valid_nie() {
        XCTAssertTrue("X1234567L".isValidNIE)
        XCTAssertTrue("Y1234567X".isValidNIE)
        XCTAssertTrue("Z1234567R".isValidNIE)
    }

    func test_is_not_valid_nie() {
        XCTAssertFalse("X1234567X".isValidNIE)
        XCTAssertFalse("Y1234567L".isValidNIE)
        XCTAssertFalse("kkk".isValidNIE)
        XCTAssertFalse("".isValidNIE)
    }
}

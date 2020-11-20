import XCTest
import Foundation
import MasMagicPills

class StringExtensionsCryptoTests: XCTestCase {
    func test_md5() {
        XCTAssertEqual("hash, hash, baby!!".md5, "A6401501F421EC8CE65C8405915ADF0D")
    }

    func test_sha256() {
        XCTAssertEqual("hash, hash, baby!!!! :D".sha256, "5EEBACE75DEDB9C94BE1E72E1229B55A02DBE2D23E5FEE0756CE6CB96673BEEB")
        XCTAssertEqual("📦".sha256, "E68EBC94437CAF84F78CF166B90ABFF24ABF4E95F30897B2A90768B59BFC0A7B")
    }

    func test_sha512() {
        XCTAssertEqual("hi, this is more secure! ;)".sha512, "53CEA135E5859223C9DD6FC050D3E7FEBA51E43B00210B20E27E1BC5FD87E67971B6646044A7C2F188E89297BB0BCAB22F31517B66CBBF1C27A43D632289FE36")
    }
}

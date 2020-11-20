import XCTest
import MasMagicPills

class CurrencyCodeTypeTests: XCTestCase {
    private let jsonHelper = JSONTestHelper()

    func test_equality() {
        XCTAssertEqual(CurrencyCodeType.euro, CurrencyCodeType.euro)
        XCTAssertNotEqual(CurrencyCodeType.euro, CurrencyCodeType.custom(CurrencyCodeType.euro.rawValue))
        XCTAssertNotEqual(CurrencyCodeType.custom("two"), CurrencyCodeType.custom("one"))
    }

    func test_encode_decode() {
        CurrencyCodeType.allCases.forEach { type in
            let error = jsonHelper.unparseAndParse(type)
            XCTAssertNil(error)
        }

        let errorCustom = jsonHelper.unparseAndParse(CurrencyCodeType.custom("WAWA"))
        XCTAssertNil(errorCustom)
    }

    func test_init_with_json_data() {
        let error1 = jsonHelper.parseAndUnparse(CurrencyCodeType.self, from: "{\"code\": \"EUR\"}") { state in
            XCTAssertEqual(state, .euro)
        }
        XCTAssertNil(error1)

        let error2 = jsonHelper.parseAndUnparse(CurrencyCodeType.self, from: "{\"code\": \"USD\"}") { state in
            XCTAssertEqual(state, .dollar)
        }
        XCTAssertNil(error2)

        let error3 = jsonHelper.parseAndUnparse(CurrencyCodeType.self, from: "{\"code\": \"CUSTOM\"}") { state in
            XCTAssertEqual(state, .custom("CUSTOM"))
        }
        XCTAssertNil(error3)
    }
}

import XCTest
import MasMagicPills

class KeyedValueTests: XCTestCase {
    private let jsonHelper = JSONTestHelper()

    func test_encode_decode() {
        let error1 = jsonHelper.unparseAndParse(KeyedValue(id: "1", value: "hola"))
        XCTAssertNil(error1)

        let error2 = jsonHelper.unparseAndParse(KeyedValue(id: "1", value: 3))
        XCTAssertNil(error2)

        let error3 = jsonHelper.unparseAndParse(KeyedValue(id: "1", value: Date()))
        XCTAssertNil(error3)
    }

    func test_init_with_json_data() {
        let error1 = jsonHelper.parseAndUnparse(KeyedValue<String?>.self, from: "{\"id\":\"1\", \"value\": null}") { value in
            XCTAssertEqual(value.id, "1")
            XCTAssertEqual(value.value, nil)
        }
        XCTAssertNil(error1)

        let error2 = jsonHelper.parseAndUnparse(LastExecutionState.self, from: "{\"wawa\":69}")
        XCTAssertNotNil(error2)
    }
}

import XCTest
import MasMagicPills

class LastExecutionStateTests: XCTestCase {
    private let jsonHelper = JSONTestHelper()

    func test_encode_decode() {
        let error1 = jsonHelper.unparseAndParse(LastExecutionState.never)
        XCTAssertNil(error1)

        let error2 = jsonHelper.unparseAndParse(LastExecutionState.failure)
        XCTAssertNil(error2)

        let error3 = jsonHelper.unparseAndParse(LastExecutionState.noData(Date()))
        XCTAssertNil(error3)

        let error4 = jsonHelper.unparseAndParse(LastExecutionState.dataUpdated(Date()))
        XCTAssertNil(error4)
    }

    func test_init_with_json_data() {
        let error1 = jsonHelper.parseAndUnparse(LastExecutionState.self, from: "{\"executionCode\":1}") { state in
            XCTAssertEqual(state, .failure)
        }
        XCTAssertNil(error1)

        let error2 = jsonHelper.parseAndUnparse(LastExecutionState.self, from: "{\"executionCode\":69}")
        XCTAssertNotNil(error2)
    }
}

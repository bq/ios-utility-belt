import XCTest
import Foundation
import MasMagicPills

class DifferenceTests: XCTestCase {
    func test_dumping_init_helper() {
        let date = "2019-08-09T10:48:00.000+0000".date()!
        let dump = String(dumping: date)
        let expectedDump = """
        ▿ 2019-08-09 10:48:00 +0000
          - timeIntervalSinceReferenceDate: 587040480.0

        """
        XCTAssertEqual(dump, expectedDump)
    }

    func test_diff_equal_dates() {
        let date1 = "2019-08-09T10:48:00.000+0000".date()!
        let date2 = "2019-08-09T10:48:00.000+0000".date()!

        let difference = diff(date1, date2).clean()

        XCTAssertTrue(difference.isEmpty)
    }

    func test_diff_of_two_dates() {
        let date1 = "2019-08-09T10:48:00.000+0000".date()!
        let date2 = "2019-06-09T11:38:00.000+0000".date()!

        let difference = diff(date1, date2).clean()

        XCTAssertEqual(difference, "timeIntervalSinceReferenceDate ↪️ - 587040480.0 ➡️ - 581773080.0")
    }

    func test_diff_of_two_dicts() {
        let dict1 = ["a": 3]
        let dict2 = ["c": 4]

        let difference = diff(dict1, dict2).clean()

        XCTAssertEqual(difference, "↪️ ▿ (2 elements)  - key: a  - value: 3 ➡️ ▿ (2 elements)  - key: c  - value: 4")
    }

    func test_diff_of_two_array() {
        let array1 = ["a", "b"]
        let array2 = ["c", "d"]

        let difference = diff(array1, array2).clean()

        XCTAssertEqual(difference, "↪️ - a ➡️ - c↪️ - b ➡️ - d")
    }

    func test_diff_of_two_array_with_system_objects() {
        let date1 = "2019-08-09T10:48:00.000+0000".date()!
        let date2 = "2016-04-09T10:48:00.000+0000".date()!
        let array1 = [date1]
        let array2 = [date2]

        let difference = diff(array1, array2).clean()

        XCTAssertEqual(difference, "different content:timeIntervalSinceReferenceDate ↪️ - 587040480.0 ➡️ - 481891680.0")
    }

    func test_diff_of_two_array_with_custom_objects() {
        let struct1 = StructOfStructs(val: TestStruct(string: "h", int: 2))
        let struct2 = StructOfStructs(val: TestStruct(string: "h", int: 3))

        let difference = diff(struct1, struct2).clean()

        XCTAssertEqual(difference, "different content (val):int ↪️ - 2 ➡️ - 3")
    }

    func test_diff_of_two_dicts_one_empty() {
        let dict1: [String: String] = [:]
        let dict2: [String: String] = ["name": "peter"]

        let difference = diff(dict1, dict2).clean()

        XCTAssertEqual(difference, "↪️ - 0 key/value pairs ➡️ ▿ 1 key/value pair  ▿ (2 elements)    - key: name    - value: peter")
    }

    func test_diff_of_two_dicts_with_different_amount_of_elements() {
        let dict1 = ["a": 3, "b": 2]
        let dict2 = ["c": 4]

        let difference = diff(dict1, dict2).clean()

        XCTAssertTrue(difference.starts(with: "different count:↪️"))
    }

    func test_diff_of_two_arrays_with_different_amount_of_elements() {
        let array1 = ["a", "b"]
        let array2 = ["c"]

        let difference = diff(array1, array2).clean()
        XCTAssertEqual(difference, "different count:↪️ ▿ 2 elements  - a  - b (1)➡️ ▿ 1 element  - c (2)")
    }

    func test_diff_of_two_structs() {
        let struct1 = TestStruct(string: "hola", int: 3)
        let struct2 = TestStruct(string: "hola", int: 5)

        let difference = diff(struct1, struct2).clean()

        XCTAssertEqual(difference, "int ↪️ - 3 ➡️ - 5")
    }

    func test_diff_of_two_enums() {
        let enum1 = TestEnum.one(str: "hola")
        let enum2 = TestEnum.one(str: "chau")

        let difference = diff(enum1, enum2).clean()

        XCTAssertEqual(difference, "one ↪️ ▿ (1 element)  - str: hola ➡️ ▿ (1 element)  - str: chau")
    }

    func test_diff_of_two_enums_from_different_case() {
        let enum1 = TestEnum.one(str: "hola")
        let enum2 = TestEnum.two(int: 2)

        let difference = diff(enum1, enum2).clean()

        XCTAssertTrue(difference.starts(with: "different label:↪️"))
    }
}

private extension Sequence where Iterator.Element == String {
    func clean() -> String {
        return self.joined()
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\"", with: "")
    }
}

private struct StructOfStructs {
    let val: TestStruct
}

private struct TestStruct {
    let string: String
    let int: Int
}

private enum TestEnum {
    case one(str: String)
    case two(int: Int)
    case three(String, String)
}

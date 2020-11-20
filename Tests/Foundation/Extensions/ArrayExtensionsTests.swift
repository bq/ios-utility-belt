import XCTest
import Foundation
import MasMagicPills

class ArrayExtensionsTests: XCTestCase {
    func test_unique() {
        XCTAssertEqual([1, 1, 2, 2, 3].unique.sorted(), [1, 2, 3].sorted())
    }

    func test_remove_existing_object() {
        var array = ["a", "b", "c", "d", "e"]

        XCTAssertTrue(array.remove("c"))
        XCTAssertEqual(array, ["a", "b", "d", "e"])
    }

    func test_remove_unexisting_object() {
        var array = ["a", "b", "c", "d", "e"]

        XCTAssertFalse(array.remove("f"))
        XCTAssertEqual(array, ["a", "b", "c", "d", "e"])
    }

    func test_appendifnotexists() {
        var array = ["a", "b"]
        XCTAssertTrue(array.appendIfNotExists("c"))
        XCTAssertFalse(array.appendIfNotExists("c"))
        XCTAssertFalse(array.appendIfNotExists(["c", "b"]))
        XCTAssertEqual(array, ["a", "b", "c"])
    }

    func test_appendingifnotexists() {
        let array = ["a", "b"]

        let newArray = array.appendingIfNotExists(["c", "b"])
        XCTAssertEqual(newArray, ["a", "b", "c"])
    }

    func test_upsert() {
        let value11 = KeyedValue(id: "1", value: "hi")
        let value12 = KeyedValue(id: "1", value: "bye")
        let value2 = KeyedValue(id: "2", value: "cya")

        var collection = [KeyedValue<String>]()

        collection.upsert(value11)
        XCTAssertEqual(collection.count, 1)
        XCTAssertEqual(collection.first { $0.id == "1" }?.value, "hi")

        collection.upsert(value12)
        XCTAssertEqual(collection.count, 1)
        XCTAssertEqual(collection.first { $0.id == "1" }?.value, "bye")

        collection.upsert(value2)
        XCTAssertEqual(collection.count, 2)
        XCTAssertEqual(collection.first { $0.id == "1" }?.value, "bye")
        XCTAssertEqual(collection.first { $0.id == "2" }?.value, "cya")

        collection.removeAll()
        collection.upsert([value11, value2])
        XCTAssertEqual(collection.count, 2)
        XCTAssertEqual(collection.first { $0.id == "1" }?.value, "hi")
        XCTAssertEqual(collection.first { $0.id == "2" }?.value, "cya")
    }

    func test_upserting() {
         let value11 = KeyedValue(id: "1", value: "hi")
         let value12 = KeyedValue(id: "1", value: "bye")
         let value2 = KeyedValue(id: "2", value: "cya")

         let collection = [value11]

         let newCollection = collection.upserting([value12, value2])
         XCTAssertEqual(newCollection.count, 2)
         XCTAssertEqual(newCollection.first { $0.id == "1" }?.value, "bye")
         XCTAssertEqual(newCollection.first { $0.id == "2" }?.value, "cya")
     }
}

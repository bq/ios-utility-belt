import XCTest
import Foundation
import MasMagicPills

class DefinesPrimaryKeyTests: XCTestCase {
    func test_wrapped_value() {
        let person1 = Person(name: "pepe", age: 33)
        let person2 = Person(name: "pepa", age: 22)
        let person3 = Person(name: "pepe", age: 44)

        XCTAssertNotEqual(person1, person2)
        XCTAssertNotEqual(person2, person3)
        XCTAssertEqual(person1, person3)
    }
}

private struct Person: DefinesPrimaryKey {
    let name: String
    let age: Int

    typealias PrimaryKey = String

    var primaryKey: PrimaryKey {
        return name
    }
}

import XCTest
import Foundation
import MagicPills

class OrderedSetTests: XCTestCase {
    func test_empty() {
        let orderedSet = OrderedSet<Int>()

        XCTAssertEqual(orderedSet.count, 0)
        XCTAssertNil(orderedSet.max)
        XCTAssertNil(orderedSet.min)
        XCTAssertNil(orderedSet.indexOf(2))
        orderedSet.forEach { _ in
            XCTFail("This never been executed because there is no elements inside")
        }
    }

    func test_one_element() {
        let element = 69
        let content = [element]
        let orderedSet = OrderedSet(initial: content)

        XCTAssertEqual(orderedSet.count, 1)
        XCTAssertEqual(orderedSet.max, element)
        XCTAssertEqual(orderedSet.min, element)
        XCTAssertEqual(orderedSet.indexOf(element), 0)
    }

    func test_three_values_order() {
        let first = "aaaa"
        let second = "bbbb"
        let third = "cccc"

        let orderedSet = OrderedSet<String>()
        orderedSet.insert(second)
        orderedSet.insert(third)
        orderedSet.insert(first)

        XCTAssertEqual(orderedSet.count, 3)
        XCTAssertFalse(orderedSet.exists("dddd"))

        XCTAssertTrue(orderedSet.exists(first))
        XCTAssertEqual(orderedSet.indexOf(first), 0)
        XCTAssertEqual(orderedSet.min, first)

        XCTAssertTrue(orderedSet.exists(second))
        XCTAssertEqual(orderedSet.indexOf(second), 1)

        XCTAssertTrue(orderedSet.exists(third))
        XCTAssertEqual(orderedSet.indexOf(third), 2)
        XCTAssertEqual(orderedSet.max, third)

        XCTAssertNil(orderedSet.indexOf("000"))
        XCTAssertNil(orderedSet.indexOf("zzz"))
    }

    func test_foreach() {
        let expected = [1, 2, 3]
        let orderedSet = OrderedSet(initial: expected)

        var index = 0
        orderedSet.forEach { item in
            XCTAssertEqual(index, orderedSet.indexOf(item))
            XCTAssertEqual(item, expected[index])
            index += 1
        }
    }

    func test_enumerated() {
        let expected = [1, 2, 3]
        let orderedSet = OrderedSet(initial: expected)

        orderedSet.enumerated().forEach { offset, item in
            XCTAssertEqual(offset, orderedSet.indexOf(item))
            XCTAssertEqual(orderedSet[offset], item)
        }
    }

    func test_add_repeated_items() {
        let orderedSet = OrderedSet<String>()

        XCTAssertTrue(orderedSet.insert(["a", "a", "a"]))
        XCTAssertFalse(orderedSet.insert("a"))
        XCTAssertFalse(orderedSet.insert(["a", "a"]))
        XCTAssertEqual(orderedSet.count, 1)
    }

    func test_insert_remove_elements() {
        let orderedSet = OrderedSet<Int>()

        XCTAssertEqual(orderedSet.count, 0)

        orderedSet.insert([2, 3])
        XCTAssertEqual(orderedSet.count, 2)

        XCTAssertTrue(orderedSet.remove(3))
        XCTAssertEqual(orderedSet.count, 1)

        XCTAssertFalse(orderedSet.remove(3))
        XCTAssertEqual(orderedSet.count, 1)

        XCTAssertEqual(orderedSet[0], 2)
    }

    func test_smallest_and_largest() {
        let orderedSet = OrderedSet(initial: ["a", "b", "c"])

        XCTAssertEqual(orderedSet.kSmallest(element: 0), nil)
        XCTAssertEqual(orderedSet.kSmallest(element: 1), "a")
        XCTAssertEqual(orderedSet.kSmallest(element: 2), "b")
        XCTAssertEqual(orderedSet.kSmallest(element: 3), "c")
        XCTAssertEqual(orderedSet.kSmallest(element: 4), nil)

        XCTAssertEqual(orderedSet.kLargest(element: 0), nil)
        XCTAssertEqual(orderedSet.kLargest(element: 1), "c")
        XCTAssertEqual(orderedSet.kLargest(element: 2), "b")
        XCTAssertEqual(orderedSet.kLargest(element: 3), "a")
        XCTAssertEqual(orderedSet.kLargest(element: 4), nil)
    }

    func test_with_values_thar_are_equal_but_dont_have_the_same_value() {
        let pj0 = Player(name: "PJ0", points: 50)
        let pj1 = Player(name: "PJ1", points: 50)
        let pj2 = Player(name: "PJ2", points: 50)
        let pj3 = Player(name: "PJ3", points: 50)
        let pj4 = Player(name: "PJ4", points: 50)
        let pj5 = Player(name: "PJ5", points: 50)
        let pj6 = Player(name: "PJ6", points: 45)
        let pj7 = Player(name: "PJ7", points: 60)
        let pj8 = Player(name: "PJ8", points: 90)
        let pj9 = Player(name: "PJ9", points: 20)

        let orderedSet = OrderedSet(initial: [pj1, pj2, pj3, pj4, pj5, pj6, pj7, pj8, pj9])

        XCTAssertEqual(orderedSet.count, 9)
        XCTAssertEqual(orderedSet.indexOf(pj9), 0)
        XCTAssertEqual(orderedSet.indexOf(pj6), 1)
        XCTAssertEqual(orderedSet.indexOf(pj1), 2)
        XCTAssertEqual(orderedSet.indexOf(pj2), 3)
        XCTAssertEqual(orderedSet.indexOf(pj3), 4)
        XCTAssertEqual(orderedSet.indexOf(pj4), 5)
        XCTAssertEqual(orderedSet.indexOf(pj5), 6)
        XCTAssertEqual(orderedSet.indexOf(pj7), 7)
        XCTAssertEqual(orderedSet.indexOf(pj8), 8)
        XCTAssertNil(orderedSet.indexOf(pj0))
    }
}

private struct Player: Comparable, Equatable {
    static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.points < rhs.points
    }

    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.points == rhs.points && lhs.name == rhs.name
    }

    let name: String
    let points: Int
}

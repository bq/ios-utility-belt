import Foundation

///  Accumulates value starting with [initial] value and applying [operation] from left to right
///  to current accumulator value and each element.
///
/// - Parameter initial: Initial value
/// - Parameter list: Array of values
/// - Parameter operation: function to be executed in each iteration
/// - Returns: fold value
public func fold<A, B>(initial: A, list: [B], operation: (A, B) -> A) -> A {
    var accumulator = initial
    for item in list {
        accumulator = operation(accumulator, item)
    }
    return accumulator
}

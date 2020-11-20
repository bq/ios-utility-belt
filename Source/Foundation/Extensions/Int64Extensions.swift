import Foundation

public extension Int64 {
    /// Return the given units of GB as bytes
    static func gigaBytes(_ amount: Int64) -> Int64 {
        return 1_024 * 1_024 * 1_024 * amount
    }

    /// Return the given units of MB as bytes
    static func megaBytes(_ amount: Int64) -> Int64 {
        return 1_024 * 1_024 * amount
    }

    var toString: String {
        return "\(self)"
    }
    
    var asNSNumber: NSNumber {
        return NSNumber(value: self)
    }
}

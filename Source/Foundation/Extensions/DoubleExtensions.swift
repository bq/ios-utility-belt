import Foundation

public extension Double {
    var toString: String {
        return "\(self)"
    }
    
    var asNSNumber: NSNumber {
        return NSNumber(value: self)
    }
}

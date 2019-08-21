import Foundation

public extension String {
    var boolValue: Bool? {
        switch self.lowercased() {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }

    var urlValue: URL? {
        return URL(string: self)
    }
}

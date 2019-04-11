import Foundation

public extension String {
    var formattedAsPhoneNumber: String {
        return String(format: "%@ %@ %@",
            String(self[self.startIndex ..< self.index(self.startIndex, offsetBy: 3)]),
            String(self[self.index(self.startIndex, offsetBy: 3) ..< self.index(self.startIndex, offsetBy: 6)]),
            String(self[self.index(self.startIndex, offsetBy: 6) ..< self.index(self.startIndex, offsetBy: 9)]))
    }
}

import Foundation

class FakeBundle: Bundle {
    var versionNumberValue: String?
    var buildNumberValue: String?

    override func object(forInfoDictionaryKey key: String) -> Any? {
        switch key {
        case "CFBundleShortVersionString": return versionNumberValue
        case "CFBundleVersion": return buildNumberValue
        default: return nil
        }
    }
}

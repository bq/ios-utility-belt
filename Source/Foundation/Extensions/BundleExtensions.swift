import Foundation

public extension Bundle {

    /// The release ("Major"."Minor"."Patch") or version number of the bundle (read-only, optional)
    var versionNumber: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    /// The version number of the bundle. (read-only, optional)
    var buildNumber: String? {
        return object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    /// Release number with version number or version number if are the same (read-only, optional)
    var fullVersionNumber: String? {
        guard let versionNumber = self.versionNumber,
              let buildNumber = self.buildNumber else {
            return nil
        }

        return versionNumber == buildNumber ? "v\(versionNumber)" : "v\(versionNumber)(\(buildNumber))"
    }
}

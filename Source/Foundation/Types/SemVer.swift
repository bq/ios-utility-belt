import Foundation

/// Wrapper for version representation according to https://semver.org
public struct Semver: Comparable, CustomStringConvertible {

    /// Initialices a Semver from a string version compatible.
    /// - Parameter string: version literal
    public init(_ string: String) {
        let splittedString = string.split(separator: ".")
        for (index, component) in splittedString.enumerated() {
            components[index] = Int(component) ?? 0
        }
    }

    /// Initialices a Semver from his components
    /// - Parameter major: major componente of the version
    /// - Parameter minor: minor componente of the version
    /// - Parameter patch: patch componente of the version
    public init(major: Int, minor: Int, patch: Int) {
        components[0] = major
        components[1] = minor
        components[2] = patch
    }

    public var major: Int {
        return components[0]
    }

    public var minor: Int {
        return components[1]
    }

    public var patch: Int {
        return components[2]
    }

    public var description: String {
        return "v\(major).\(minor).\(patch)"
    }

    // Private

    private var components = [Int](repeating: 0, count: 3)
}

public func < (lhs: Semver, rhs: Semver) -> Bool {
    if lhs.major == rhs.major {
        if lhs.minor == rhs.minor {
            return lhs.patch < rhs.patch
        }
        return lhs.minor < rhs.minor
    }
    return lhs.major < rhs.major
}

public func == (lhs: Semver, rhs: Semver) -> Bool {
    if lhs.major == rhs.major && lhs.minor == rhs.minor {
        return lhs.patch == rhs.patch
    }
    return false
}

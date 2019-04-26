import UIKit

public extension UIFont {

    // Return same font with bold trait (read-only)
    var bold: UIFont? {
        if fontDescriptor.symbolicTraits.contains(.traitBold) { return self }
        return with(traits: .traitBold)
    }

    // Return same font with italic trait (read-only)
    var italic: UIFont? {
        if fontDescriptor.symbolicTraits.contains(.traitItalic) { return self }
        return with(traits: .traitItalic)
    }

    // Return same font with bold italic trait (read-only)
    var boldItalic: UIFont? {
        if fontDescriptor.symbolicTraits.contains([.traitBold, .traitItalic]) { return self }
        return with(traits: [.traitBold, .traitItalic])
    }

    /// To get regular font with custom size
    ///
    /// - Parameter size: Font size
    /// - Returns: System regular font
    static func systemRegular(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }

    /// To get bold font with custom size
    ///
    /// - Parameter size: Font size
    /// - Returns: System bold font
    static func systemBold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }

    /// To get medium font with custom size
    ///
    /// - Parameter size: Font size
    /// - Returns: System medium font
    static func systemMedium(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }

    /// To get light font with custom size
    ///
    /// - Parameter size: Font size
    /// - Returns: System light font
    static func systemLight(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }

    private func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont? {
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else { return nil }
        return UIFont(descriptor: descriptor, size: 0)
    }
}

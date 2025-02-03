import AppKit

struct MenuItem {
    let title: String
    let action: Selector?
    let keyEquivalent: String
    let isSeparator: Bool
    let useAppTarget: Bool
    
    static let separator = MenuItem(
        title: "",
        action: nil,
        keyEquivalent: "",
        isSeparator: true,
        useAppTarget: false
    )
    
    static func item(title: String, action: Selector, key: String = "", useAppTarget: Bool = false) -> MenuItem {
        MenuItem(
            title: title,
            action: action,
            keyEquivalent: key,
            isSeparator: false,
            useAppTarget: useAppTarget
        )
    }
}
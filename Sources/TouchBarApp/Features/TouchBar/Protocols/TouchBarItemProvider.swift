import AppKit

protocol TouchBarItemProvider {
    var identifier: NSTouchBarItem.Identifier { get }
    
    func makeItem() -> NSTouchBarItem?
}

extension TouchBarItemProvider {
    func makeCustomItem() -> NSCustomTouchBarItem {
        return NSCustomTouchBarItem(identifier: identifier)
    }
    func makeButton(title: String, target: AnyObject?, action: Selector) -> NSButton {
        return NSButton(title: title, target: target, action: action)
    }
}
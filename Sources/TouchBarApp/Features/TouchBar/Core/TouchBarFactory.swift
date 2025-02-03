import AppKit

final class TouchBarFactory {
    private static var delegates: [String: TouchBarDelegate] = [:]

    static func makeTouchBar(with configuration: TouchBarConfigurable) -> NSTouchBar {
        let touchBar = NSTouchBar()

        touchBar.defaultItemIdentifiers = configuration.defaultItemIdentifiers

        let delegate = TouchBarDelegate(configuration: configuration)
        let delegateKey = String(describing: ObjectIdentifier(touchBar))
        delegates[delegateKey] = delegate
        touchBar.delegate = delegate
        
        return touchBar
    }
    
    static func makeGroupItem(identifier: NSTouchBarItem.Identifier, items: [TouchBarItemProvider]) -> NSGroupTouchBarItem {
        let groupItem = NSGroupTouchBarItem(identifier: identifier)
        let configuration = TouchBarGroupConfiguration(items: items)
        
        let groupTouchBar = NSTouchBar()
        groupTouchBar.defaultItemIdentifiers = configuration.defaultItemIdentifiers
        
        let delegate = TouchBarDelegate(configuration: configuration)
        let delegateKey = String(describing: ObjectIdentifier(groupTouchBar))
        delegates[delegateKey] = delegate
        groupTouchBar.delegate = delegate
        
        groupItem.groupTouchBar = groupTouchBar
        
        return groupItem
    }
    
    static func clearDelegate(for touchBar: NSTouchBar) {
        let delegateKey = String(describing: ObjectIdentifier(touchBar))
        delegates.removeValue(forKey: delegateKey)
    }
    
    static func cleanup() {
        delegates.removeAll()
    }
    
    static func makeCustomItem(identifier: NSTouchBarItem.Identifier, viewController: NSViewController? = nil) -> NSCustomTouchBarItem {
        let item = NSCustomTouchBarItem(identifier: identifier)
        if let vc = viewController {
            item.viewController = vc
        }
        return item
    }
    
    static func hasDelegate(for touchBar: NSTouchBar) -> Bool {
        let key = String(describing: ObjectIdentifier(touchBar))
        return delegates[key] != nil
    }
}
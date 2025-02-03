import AppKit

protocol TouchBarConfigurable: NSObjectProtocol {
    var defaultItemIdentifiers: [NSTouchBarItem.Identifier] { get }
    
    var touchBar: NSTouchBar? { get }
    
    func makeItem(for identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem?
}

extension TouchBarConfigurable where Self: NSObject {
    var touchBar: NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self as? NSTouchBarDelegate
        touchBar.defaultItemIdentifiers = defaultItemIdentifiers
        return touchBar
    }
}
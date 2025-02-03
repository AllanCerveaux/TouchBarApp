import AppKit

final class TouchBarDelegate: NSObject, NSTouchBarDelegate {
    private let configuration: TouchBarConfigurable
    
    private var itemCache: [NSTouchBarItem.Identifier: NSTouchBarItem] = [:]
    
    init(configuration: TouchBarConfigurable) {
        self.configuration = configuration
        super.init()
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        if let cachedItem = itemCache[identifier] {
            return cachedItem
        }
        
        let item = configuration.makeItem(for: identifier)
        
        if let item = item {
            itemCache[identifier] = item
        }
        
        return item
    }
}
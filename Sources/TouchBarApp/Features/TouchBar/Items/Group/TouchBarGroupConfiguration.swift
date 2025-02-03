class TouchBarGroupConfiguration: NSObject, TouchBarConfigurable, NSTouchBarDelegate {
    let items: [TouchBarItemProvider]
    let customizationLabel: String?
    
    var defaultItemIdentifiers: [NSTouchBarItem.Identifier] {
        return items.map { $0.identifier }
    }
    
    var touchBar: NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.defaultItemIdentifiers = defaultItemIdentifiers
        return touchBar
    }
    
    init(items: [TouchBarItemProvider], customizationLabel: String? = nil) {
        self.items = items
        self.customizationLabel = customizationLabel
        super.init()
    }
    
    func makeItem(for identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        return items.first { $0.identifier == identifier }?.makeItem()
    }
}
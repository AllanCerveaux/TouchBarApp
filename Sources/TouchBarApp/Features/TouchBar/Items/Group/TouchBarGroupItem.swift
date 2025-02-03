final class TouchBarGroupItem: BaseTouchBarItem {
    static let defaultIdentifier = NSTouchBarItem.Identifier("com.touchbar.group")
    
    private let configuration: TouchBarGroupConfiguration
    private weak var touchBarItem: NSGroupTouchBarItem?
    private var groupDelegate: TouchBarDelegate?
    
    init(identifier: NSTouchBarItem.Identifier = TouchBarGroupItem.defaultIdentifier,
         configuration: TouchBarGroupConfiguration) {
        self.configuration = configuration
        super.init(identifier: identifier)
    }
    
    override func makeItem() -> NSTouchBarItem? {
        let item = NSGroupTouchBarItem(identifier: identifier)
        let groupTouchBar = makeGroupTouchBar()
        
        item.groupTouchBar = groupTouchBar
        item.customizationLabel = configuration.customizationLabel
        touchBarItem = item
        
        return item
    }
    
    private func makeGroupTouchBar() -> NSTouchBar {
        let touchBar = NSTouchBar()
        touchBar.defaultItemIdentifiers = configuration.defaultItemIdentifiers
        
        groupDelegate = TouchBarDelegate(configuration: configuration)
        touchBar.delegate = groupDelegate
        
        return touchBar
    }
}
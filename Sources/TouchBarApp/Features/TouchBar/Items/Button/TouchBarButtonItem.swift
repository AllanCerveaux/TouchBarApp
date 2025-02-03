import AppKit

final class TouchBarButtonItem: BaseTouchBarItem {
    static let defaultIdentifier = TouchBarItemIdentifier.button
    private let configuration: TouchBarButtonConfiguration
    private weak var touchBarItem: NSCustomTouchBarItem?

    init(identifier: NSTouchBarItem.Identifier = defaultIdentifier, 
         configuration: TouchBarButtonConfiguration) {
        self.configuration = configuration
        super.init(identifier: identifier)
    }
    
    static func makeIdentifier(id: String) -> NSTouchBarItem.Identifier {
        return TouchBarItemIdentifier.customButton(id: id)
    }
    
    override func makeItem() -> NSTouchBarItem? {
        let item = makeCustomItem()
        let button = configureButton()
        item.view = button
        touchBarItem = item
        return item
    }
    
    private func configureButton() -> NSButton {
        let button = NSButton(title: configuration.title ?? "", 
                            target: configuration.target, 
                            action: configuration.action)
        
        if let image = configuration.image {
            button.image = image
            button.imagePosition = configuration.title == nil ? .imageOnly : .imageLeft
        }
        
        if let bezelColor = configuration.bezelColor {
            button.bezelColor = bezelColor
        }
        
        return button
    }
    
    func updateTitle(_ title: String) {
        guard let button = touchBarItem?.view as? NSButton else { return }
        button.title = title
    }
    
    func updateImage(_ image: NSImage?) {
        guard let button = touchBarItem?.view as? NSButton else { return }
        button.image = image
        button.imagePosition = configuration.title == nil ? .imageOnly : .imageLeft
    }
    
    func updateBezelColor(_ color: NSColor) {
        guard let button = touchBarItem?.view as? NSButton else { return }
        button.bezelColor = color
    }
    
    func setEnabled(_ enabled: Bool) {
        guard let button = touchBarItem?.view as? NSButton else { return }
        button.isEnabled = enabled
    }
}
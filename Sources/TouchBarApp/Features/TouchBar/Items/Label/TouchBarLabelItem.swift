import AppKit

final class TouchBarLabelItem: BaseTouchBarItem {
    static let identifier = NSTouchBarItem.Identifier("com.touchbar.label")
    static let statusIdentifier = NSTouchBarItem.Identifier("com.touchbar.label.status")

    private let configuration: TouchBarLabelConfiguration
    private weak var touchBarItem: NSCustomTouchBarItem?
    
    init(identifier: NSTouchBarItem.Identifier = TouchBarLabelItem.identifier, configuration: TouchBarLabelConfiguration) {
        self.configuration = configuration
        super.init(identifier: identifier)
    }
    
    override func makeItem() -> NSTouchBarItem? {
        let item = makeCustomItem()
        let label = NSTextField(labelWithString: configuration.text)
        
        label.textColor = configuration.textColor
        label.font = configuration.font
        label.alignment = configuration.alignment
        label.backgroundColor = .clear
        label.isBezeled = false
        label.isEditable = false
        
        item.view = label
        touchBarItem = item
        return item
    }
    
    func updateText(_ text: String) {
        guard let label = touchBarItem?.view as? NSTextField else { return }
        label.stringValue = text
    }
    
    func updateTextColor(_ color: NSColor) {
        guard let label = touchBarItem?.view as? NSTextField else { return }
        label.textColor = color
    }
    
    func updateFont(_ font: NSFont) {
        guard let label = touchBarItem?.view as? NSTextField else { return }
        label.font = font
    }
}
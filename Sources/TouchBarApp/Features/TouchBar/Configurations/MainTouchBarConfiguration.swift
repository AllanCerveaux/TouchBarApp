import AppKit

final class MainTouchBarConfiguration: NSObject, TouchBarConfigurable {
    private var touchBarItems: [TouchBarItemProvider] = []
    var defaultItemIdentifiers: [NSTouchBarItem.Identifier] {
        return touchBarItems.map { $0.identifier }
    }
    
    func makeItem(for identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        return touchBarItems.first { $0.identifier == identifier }?.makeItem()
    }
    
    override init() {
        super.init()
        setupTouchBarItems()
    }
    
    private func setupTouchBarItems() {
        let buttonConfig = TouchBarButtonConfiguration(
            title: "Action",
            image: NSImage(systemSymbolName: "star.fill", accessibilityDescription: "Action"),
            target: self,
            action: #selector(buttonTapped),
            bezelColor: .systemBlue
        )
        
        let labelConfig = TouchBarLabelConfiguration(
            text: "Status",
            textColor: .touchBarText,
            font: .systemFont(ofSize: 13),
            alignment: .center
        )
        
        let button = TouchBarButtonItem(
            identifier: TouchBarButtonItem.makeIdentifier(id: "action"),
            configuration: buttonConfig
        )
        
        let label = TouchBarLabelItem(
            identifier: TouchBarLabelItem.statusIdentifier,
            configuration: labelConfig
        )
        
        touchBarItems = [button, label]
    }
    
    @objc private func buttonTapped() {
        NSLog("TouchBar button tapped")
    }
}
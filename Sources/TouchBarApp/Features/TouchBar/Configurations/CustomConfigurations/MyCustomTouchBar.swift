import AppKit

final class MyCustomTouchBar: NSObject, TouchBarConfigurable {
    private var touchBarItems: [TouchBarItemProvider] = []
    private let groupIdentifier = TouchBarItemIdentifier.controls
    private let labelIdentifier = TouchBarItemIdentifier.status
    
    var defaultItemIdentifiers: [NSTouchBarItem.Identifier] {
        return [groupIdentifier, labelIdentifier]
    }
    
    func makeItem(for identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        return touchBarItems.first { $0.identifier == identifier }?.makeItem()
    }

    override init() {
        super.init()
        setupTouchBarItems()
    }

    private func setupTouchBarItems() {

        let playButton = TouchBarButtonItem(
            identifier: TouchBarItemIdentifier.play,
            configuration: TouchBarButtonConfiguration(
                title: "Play",
                image: NSImage(systemSymbolName: "play.fill", accessibilityDescription: "Play"),
                target: self,
                action: #selector(playTapped),
                bezelColor: nil
            )
        )
        
        let pauseButton = TouchBarButtonItem(
            identifier: TouchBarItemIdentifier.pause,
            configuration: TouchBarButtonConfiguration(
                title: "Pause",
                image: NSImage(systemSymbolName: "pause.fill", accessibilityDescription: "Pause"),
                target: self,
                action: #selector(pauseTapped),
                bezelColor: nil
            )
        )
        
        let statusLabel = TouchBarLabelItem(
            identifier: labelIdentifier,
            configuration: TouchBarLabelConfiguration(
                text: "Ready",
                textColor: .touchBarText,
                font: .systemFont(ofSize: 13),
                alignment: .center
            )
        )
        
        let controlsGroup = TouchBarGroupItem(
            identifier: groupIdentifier,
            configuration: TouchBarGroupConfiguration(
                items: [playButton, pauseButton],
                customizationLabel: "Controls"
            )
        )
        
        touchBarItems = [controlsGroup, statusLabel]
    }
    
    @objc private func playTapped() {
        NSLog("Play tapped")
        if let label = touchBarItems.first(where: { $0.identifier == labelIdentifier }) as? TouchBarLabelItem {
            label.updateText("Playing...")
        }
    }
    
    @objc private func pauseTapped() {
        NSLog("Pause tapped")
        if let label = touchBarItems.first(where: { $0.identifier == labelIdentifier }) as? TouchBarLabelItem {
            label.updateText("Paused")
        }
    }
}
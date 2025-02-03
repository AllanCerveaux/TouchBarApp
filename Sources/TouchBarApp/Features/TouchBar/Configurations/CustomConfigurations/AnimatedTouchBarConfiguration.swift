import AppKit

final class AnimatedTouchBarConfiguration: NSObject, TouchBarConfigurable {
    private var touchBarItems: [TouchBarItemProvider] = []
    private var isPlaying = false
    
    var defaultItemIdentifiers: [NSTouchBarItem.Identifier] {
        return touchBarItems.map { $0.identifier }
    }
    
    override init() {
        super.init()
        setupTouchBarItems()
    }
    
    private func setupTouchBarItems() {
        let playButton = TouchBarButtonItem(
            identifier: TouchBarItemIdentifier.customButton(id: "play"),
            configuration: TouchBarButtonConfiguration(
                title: "Play",
                image: NSImage(systemSymbolName: "play.fill", accessibilityDescription: "Play"),
                target: self,
                action: #selector(playButtonTapped),
                bezelColor: .systemBlue
            )
        )
        
        let statusLabel = TouchBarLabelItem(
            identifier: TouchBarItemIdentifier.customLabel(id: "status"),
            configuration: TouchBarLabelConfiguration(
                text: "Ready",
                textColor: .touchBarText,
                font: .systemFont(ofSize: 15),
                alignment: .center
            )
        )
        
        touchBarItems = [playButton, statusLabel]
    }
    
    @objc private func playButtonTapped() {
        guard let button = touchBarItems.first(where: { $0.identifier.rawValue.contains("play") }) as? TouchBarButtonItem,
              let label = touchBarItems.first(where: { $0.identifier.rawValue.contains("status") }) as? TouchBarLabelItem,
              let buttonView = button.makeItem()?.view as? NSButton,
              let labelView = label.makeItem()?.view as? NSTextField else {
            return
        }
        
        isPlaying.toggle()
        
        TouchBarAnimator.animateButtonColor(
            buttonView,
            to: isPlaying ? .systemGreen : .systemBlue,
            duration: 0.3
        ) {
            let imageName = self.isPlaying ? "pause.fill" : "play.fill"
            button.updateImage(NSImage(systemSymbolName: imageName, accessibilityDescription: nil))
        }
        
        TouchBarAnimator.fadeOut(labelView, duration: 0.15) {
            label.updateText(self.isPlaying ? "Playing..." : "Ready")
            TouchBarAnimator.fadeIn(labelView, duration: 0.15)
        }
    }
    
    func makeItem(for identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        return touchBarItems.first { $0.identifier == identifier }?.makeItem()
    }
}
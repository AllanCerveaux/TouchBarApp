import AppKit

struct TouchBarButtonConfiguration {
    let title: String?
    let image: NSImage?
    let target: AnyObject?
    let action: Selector?
    let bezelColor: NSColor?
    
    init(
        title: String? = nil,
        image: NSImage? = nil,
        target: AnyObject? = nil,
        action: Selector? = nil,
        bezelColor: NSColor? = nil
    ) {
        self.title = title
        self.image = image
        self.target = target
        self.action = action
        self.bezelColor = bezelColor
    }
}
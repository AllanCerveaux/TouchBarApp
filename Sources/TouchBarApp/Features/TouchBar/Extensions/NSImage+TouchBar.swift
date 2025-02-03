import AppKit

extension NSImage {
    static func touchBarImage(named name: String) -> NSImage? {
        return NSImage(named: NSImage.Name(name))?.withTouchBarRepresentation()
    }
    
    func withTouchBarRepresentation() -> NSImage {
        let touchBarImage = NSImage(size: size)
        touchBarImage.isTemplate = true
        touchBarImage.lockFocus()
        draw(in: NSRect(origin: .zero, size: size))
        touchBarImage.unlockFocus()
        return touchBarImage
    }
}
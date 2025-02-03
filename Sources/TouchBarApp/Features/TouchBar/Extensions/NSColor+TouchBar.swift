import AppKit

extension NSColor {
    static var touchBarBackground: NSColor {
        return NSColor(deviceWhite: 0.2, alpha: 1.0)
    }
    
    static var touchBarHighlight: NSColor {
        return NSColor(deviceRed: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
    }
    
    static var touchBarText: NSColor {
        return .white
    }
}
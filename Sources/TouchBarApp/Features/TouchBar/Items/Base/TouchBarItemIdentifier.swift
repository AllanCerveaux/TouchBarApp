import AppKit

struct TouchBarItemIdentifier {
    private static let prefix = "com.touchbar"

    static let button = NSTouchBarItem.Identifier("\(prefix).button")
    static let label = NSTouchBarItem.Identifier("\(prefix).label")
    static let group = NSTouchBarItem.Identifier("\(prefix).group")
    
    static let play = NSTouchBarItem.Identifier("\(prefix).controls.play")
    static let pause = NSTouchBarItem.Identifier("\(prefix).controls.pause")
    static let status = NSTouchBarItem.Identifier("\(prefix).status")
    static let controls = NSTouchBarItem.Identifier("\(prefix).controls")
    
    static func customButton(id: String) -> NSTouchBarItem.Identifier {
        return NSTouchBarItem.Identifier("\(prefix).button.\(id)")
    }
    
    static func customGroup(id: String) -> NSTouchBarItem.Identifier {
        return NSTouchBarItem.Identifier("\(prefix).group.\(id)")
    }
    
    static func customLabel(id: String) -> NSTouchBarItem.Identifier {
        return NSTouchBarItem.Identifier("\(prefix).label.\(id)")
    }
}
import AppKit

class BaseTouchBarItem: NSObject, TouchBarItemProvider {
    let identifier: NSTouchBarItem.Identifier
    
    init(identifier: NSTouchBarItem.Identifier) {
        self.identifier = identifier
        super.init()
    }
    
    func makeItem() -> NSTouchBarItem? {
        fatalError("This method must be implemented by the child classes")
    }
}
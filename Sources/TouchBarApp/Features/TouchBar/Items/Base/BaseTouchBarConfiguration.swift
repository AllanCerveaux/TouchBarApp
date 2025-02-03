import AppKit

class BaseTouchBarConfiguration: NSObject, TouchBarConfigurable {
    private(set) var items: [TouchBarItemProvider] = []
    var defaultItemIdentifiers: [NSTouchBarItem.Identifier] {
        return items.map { $0.identifier }
    }
    
    func makeItem(for identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        return items.first { $0.identifier == identifier }?.makeItem()
    }
    
    func addItem(_ item: TouchBarItemProvider) {
        items.append(item)
    }
    
    func removeItem(with identifier: NSTouchBarItem.Identifier) {
        items.removeAll { $0.identifier == identifier }
    }
    
    func clearItems() {
        items.removeAll()
    }
    
    func getItem<T: TouchBarItemProvider>(of type: T.Type, with identifier: NSTouchBarItem.Identifier) -> T? {
        return items.first { $0.identifier == identifier } as? T
    }
    
    func setupItems() {}
}
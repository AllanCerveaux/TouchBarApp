import AppKit

protocol TouchBarStateObserver: AnyObject {
    func touchBarStateDidChange(_ state: TouchBarState)
}

final class TouchBarMonitor {
    static let shared = TouchBarMonitor()
    
    private var observers: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    
    func addObserver(_ observer: TouchBarStateObserver) {
        observers.add(observer as AnyObject)
    }
    
    func removeObserver(_ observer: TouchBarStateObserver) {
        observers.remove(observer as AnyObject)
    }
    
    func notifyStateChange(_ state: TouchBarState) {
        observers.allObjects.compactMap { $0 as? TouchBarStateObserver }
            .forEach { $0.touchBarStateDidChange(state) }
    }
}
import AppKit

final class StatusBarController: NSObject {
    private var statusItem: NSStatusItem
    
    weak var delegate: StatusBarMenuDelegate? {
        didSet {
            refreshMenu()
        }
    }

    override init() {
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        super.init()
        
        configureStatusItem()
        setupMenu()
    }

    func refreshMenu() {
        guard let menu = statusItem.menu else { return }
        menu.removeAllItems()
        
        let items = delegate?.items() ?? []
        
        for item in items {
            if item.isSeparator {
                menu.addItem(NSMenuItem.separator())
            } else {
                let menuItem = NSMenuItem(
                    title: item.title,
                    action: item.action,
                    keyEquivalent: item.keyEquivalent
                )
                menuItem.target = item.useAppTarget ? NSApp : delegate
                menu.addItem(menuItem)
            }
        }
    }
    
    func updateMenuItemState(for title: String, isEnabled: Bool) {
        guard let menu = statusItem.menu else { return }
        menu.items.first { $0.title == title }?.isEnabled = isEnabled
    }
    
    func updateMenuItemTitle(for identifier: String, newTitle: String) {
        guard let menu = statusItem.menu else { return }
        if let item = menu.items.first(where: { $0.title == identifier }) {
            item.title = newTitle
        }
    }
    
    private func configureStatusItem() {
        if let button = statusItem.button {
            button.image = NSImage(
                systemSymbolName: "rectangle.and.pencil.and.ellipsis", 
                accessibilityDescription: "Touch Bar"
            )
        }
    }
    
    private func setupMenu() {
        let menu = NSMenu()
        statusItem.menu = menu
        refreshMenu()
    }
}
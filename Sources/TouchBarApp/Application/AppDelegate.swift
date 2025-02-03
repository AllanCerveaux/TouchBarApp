
import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate, NSTouchBarProvider {
    private var statusBarController: StatusBarController?
    private lazy var touchBarManager: TouchBarManager = {
        let manager = TouchBarManager.shared
        setupTouchBarConfigurations(manager)
        return manager
    }()
    
    private enum TouchBarConfigKey {
        static let main = "main"
        static let custom = "custom"
        static let temporary = "temporary"
        static let animated = "animated"
    }
    
    var touchBar: NSTouchBar? {
        return touchBarManager.currentTouchBar
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupApplication()
        setupTouchBar()
        setupStatusBar()
        
        TouchBarMonitor.shared.addObserver(self)
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        cleanup()
    }
    
    private func setupApplication() {
        NSApplication.shared.setActivationPolicy(.accessory)
    }
    
    private func setupTouchBar() {
        do {
            try touchBarManager.presentTouchBar(withConfigurationKey: TouchBarConfigKey.main)
        } catch {
            NSLog("Erreur lors de l'initialisation de la TouchBar: \(error)")
        }
    }
    
    private func setupStatusBar() {
        let controller = StatusBarController()
        controller.delegate = self
        self.statusBarController = controller
    }
    
    private func setupTouchBarConfigurations(_ manager: TouchBarManager) {
        manager.registerConfiguration(
            MainTouchBarConfiguration(),
            forKey: TouchBarConfigKey.main
        )
        manager.registerConfiguration(
            MyCustomTouchBar(),
            forKey: TouchBarConfigKey.custom
        )
        manager.registerConfiguration(
            AnimatedTouchBarConfiguration(),
            forKey: TouchBarConfigKey.animated
        )
    }
    
    private func cleanup() {
        TouchBarMonitor.shared.removeObserver(self)
        touchBarManager.cleanup()
    }
}

extension AppDelegate: StatusBarMenuDelegate {
    func items() -> [MenuItem] {
        [
            MenuItem.item(title: "Show main TouchBar", action: #selector(showMainTouchBar)),
            MenuItem.item(title: "Show customised TouchBar", action: #selector(showCustomTouchBar)),
            MenuItem.item(title: "Show animated TouchBar", action: #selector(showAnimatedTouchBar)),
            MenuItem.item(title: "Hide TouchBar", action: #selector(hideTouchBar)),
            MenuItem.separator,
            MenuItem.item(
                title: "Exit", 
                action: #selector(NSApplication.terminate(_:)), 
                key: "q", 
                useAppTarget: true
            )
        ]
    }
    
    @objc private func showMainTouchBar() {
        try? touchBarManager.presentTouchBar(withConfigurationKey: TouchBarConfigKey.main)
    }
    
    @objc private func showCustomTouchBar() {
        try? touchBarManager.presentTouchBar(withConfigurationKey: TouchBarConfigKey.custom)
    }
    
    @objc private func showAnimatedTouchBar() {
        try? touchBarManager.presentTouchBar(withConfigurationKey: TouchBarConfigKey.animated)
    }
    
    @objc private func hideTouchBar() {
        touchBarManager.dismissTouchBar()
    }
}

extension AppDelegate: TouchBarStateObserver {
    func touchBarStateDidChange(_ state: TouchBarState) {
        switch state {
        case .visible:
            NSLog("TouchBar is now visible")
            statusBarController?.updateMenuItemState(for: "Hide TouchBar", isEnabled: true)
            statusBarController?.updateMenuItemState(for: "Show main TouchBar", isEnabled: false)
            statusBarController?.updateMenuItemState(for: "Show customised TouchBar", isEnabled: false)
        
        case .hidden:
            NSLog("TouchBar est maintenant masquée")
            statusBarController?.updateMenuItemState(for: "Masquer TouchBar", isEnabled: false)
            statusBarController?.updateMenuItemState(for: "Show main TouchBar", isEnabled: true)
            statusBarController?.updateMenuItemState(for: "Show customised TouchBar", isEnabled: true)
            
        case .error(let error):
            NSLog("TouchBar error: \(error.localizedDescription)")
            statusBarController?.refreshMenu()
            
        case .notInitialized:
            NSLog("TouchBar is not initialised")
            statusBarController?.refreshMenu()
        }
    }
}

import AppKit

enum TouchBarState: Equatable {
    case notInitialized
    case visible
    case hidden
    case error(Error)
    
    static func == (lhs: TouchBarState, rhs: TouchBarState) -> Bool {
        switch (lhs, rhs) {
        case (.notInitialized, .notInitialized),
             (.visible, .visible),
             (.hidden, .hidden):
            return true
        case (.error(let error1), .error(let error2)):
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
}

enum TouchBarManagerError: LocalizedError {
    case configurationNotFound
    case touchBarCreationFailed
    case invalidState
    case presentationFailed
    
    var errorDescription: String? {
        switch self {
        case .configurationNotFound:
            return "The requested configuration was not found"
        case .touchBarCreationFailed:
            return "TouchBar creation failed"
        case .invalidState:
            return "Invalid TouchBar status"
        case .presentationFailed:
            return "TouchBar presentation fails"
        }
    }
}

final class TouchBarManager {
    static let shared = TouchBarManager()
    
    private(set) var currentTouchBar: NSTouchBar?
    
    private(set) var currentConfiguration: TouchBarConfigurable?
    
    private(set) var state: TouchBarState = .notInitialized {
        didSet {
            TouchBarMonitor.shared.notifyStateChange(state)
        }
    }
    
    private var storedConfigurations: [String: TouchBarConfigurable] = [:]
    
    private init() {
        setupDefaultTouchBar()
    }
    
    func registerConfiguration(_ configuration: TouchBarConfigurable, forKey key: String) {
        storedConfigurations[key] = configuration
    }
    
    func getConfiguration(forKey key: String) -> TouchBarConfigurable? {
        return storedConfigurations[key]
    }
    
    func removeConfiguration(forKey key: String) {
        storedConfigurations.removeValue(forKey: key)
    }
    
    func presentTouchBar(with configuration: TouchBarConfigurable) throws {
        guard validateConfiguration(configuration) else {
            throw TouchBarManagerError.invalidState
        }
        
        if let existing = currentTouchBar {
            NSTouchBar.dismissSystemModalTouchBar(existing)
            TouchBarFactory.clearDelegate(for: existing)
        }
        
        do {
            let touchBar = try createTouchBar(with: configuration)
            
            NSTouchBar.presentSystemModalTouchBar(touchBar, placement: 1, systemTrayItemIdentifier: nil)

            currentTouchBar = touchBar
            currentConfiguration = configuration
            state = .visible
            
        } catch {
            state = .error(error)
            throw error
        }
    }
    
    func presentTouchBar(withConfigurationKey key: String) throws {
        guard let configuration = storedConfigurations[key] else {
            throw TouchBarManagerError.configurationNotFound
        }
        try presentTouchBar(with: configuration)
    }

    func dismissTouchBar() {
        if let touchBar = currentTouchBar {
            NSTouchBar.dismissSystemModalTouchBar(touchBar)
            TouchBarFactory.clearDelegate(for: touchBar)
            
            currentTouchBar = nil
            currentConfiguration = nil
            state = .hidden
        }
    }
    
    func reloadTouchBar() throws {
        if let config = currentConfiguration {
            try presentTouchBar(with: config)
        } else {
            setupDefaultTouchBar()
        }
    }
    
    func cleanup() {
        dismissTouchBar()
        storedConfigurations.removeAll()
        TouchBarFactory.cleanup()
        state = .notInitialized
    }
    
    private func setupDefaultTouchBar() {
        if case .notInitialized = state {
            let configuration = MyCustomTouchBar()
            try? presentTouchBar(with: configuration)
        }
    }
    
    private func createTouchBar(with configuration: TouchBarConfigurable) throws -> NSTouchBar {
        let touchBar = TouchBarFactory.makeTouchBar(with: configuration)
        guard touchBar.delegate != nil else {
            throw TouchBarManagerError.touchBarCreationFailed
        }
        return touchBar
    }
    
    private func validateConfiguration(_ configuration: TouchBarConfigurable) -> Bool {
        guard !configuration.defaultItemIdentifiers.isEmpty else {
            return false
        }
        return true
    }
}

extension TouchBarManager {
    var isVisible: Bool {
        if case .visible = state {
            return true
        }
        return false
    }

    var hasError: Bool {
        if case .error = state {
            return true
        }
        return false
    }

    func getCurrentError() -> Error? {
        if case .error(let error) = state {
            return error
        }
        return nil
    }
    
    func applyTemporaryConfiguration(_ configuration: TouchBarConfigurable) -> (() -> Void) {
        let previousConfiguration = currentConfiguration
        try? presentTouchBar(with: configuration)
        
        return { [weak self] in
            if let previous = previousConfiguration {
                try? self?.presentTouchBar(with: previous)
            }
        }
    }
}

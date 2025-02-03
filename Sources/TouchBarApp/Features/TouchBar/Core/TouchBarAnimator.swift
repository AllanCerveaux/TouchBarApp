import AppKit

final class TouchBarAnimator {
    typealias AnimationCompletion = () -> Void
    private static let defaultDuration: TimeInterval = 0.3
    
    static func animateButtonColor(_ button: NSButton, 
                                 to color: NSColor, 
                                 duration: TimeInterval = defaultDuration,
                                 completion: AnimationCompletion? = nil) {
        NSAnimationContext.runAnimationGroup { context in
            context.duration = duration
            button.animator().bezelColor = color
        } completionHandler: {
            completion?()
        }
    }
    
    static func fadeIn(_ view: NSView,
                      duration: TimeInterval = defaultDuration,
                      completion: AnimationCompletion? = nil) {
        view.alphaValue = 0
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = duration
            view.animator().alphaValue = 1
        } completionHandler: {
            completion?()
        }
    }
    
    static func fadeOut(_ view: NSView,
                       duration: TimeInterval = defaultDuration,
                       completion: AnimationCompletion? = nil) {
        NSAnimationContext.runAnimationGroup { context in
            context.duration = duration
            view.animator().alphaValue = 0
        } completionHandler: {
            completion?()
        }
    }
    
    static func updateLabel(_ label: NSTextField,
                          withText text: String,
                          animated: Bool = true,
                          duration: TimeInterval = defaultDuration) {
        if animated {
            fadeOut(label, duration: duration / 2) {
                label.stringValue = text
                fadeIn(label, duration: duration / 2)
            }
        } else {
            label.stringValue = text
        }
    }
}
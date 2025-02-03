import AppKit

protocol StatusBarMenuDelegate: AnyObject {
    func items() -> [MenuItem]
}
import AppKit

struct TouchBarLabelConfiguration {
    let text: String
    let textColor: NSColor
    let font: NSFont
    let alignment: NSTextAlignment
    
    init(
        text: String,
        textColor: NSColor = .touchBarText,
        font: NSFont = .systemFont(ofSize: 15),
        alignment: NSTextAlignment = .center
    ) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.alignment = alignment
    }
}
//
//  TextDocumentProxyWrapper.swift
//  QWERTY_Mini
//
//  Created on 25/7/2025.
//

import UIKit

class TextDocumentProxyWrapper: NSObject, UITextDocumentProxy {
    weak var textView: UITextView?
    private var markedText: String = ""
    private var markedTextPosition: Int = 0
    
    init(textView: UITextView) {
        self.textView = textView
        super.init()
    }
    
    // MARK: - UITextDocumentProxy Properties
    
    var documentContextBeforeInput: String? {
        guard let textView = textView,
              let selectedRange = textView.selectedTextRange else { return nil }
        
        let beginning = textView.beginningOfDocument
        let start = selectedRange.start
        
        guard let range = textView.textRange(from: beginning, to: start) else { return nil }
        return textView.text(in: range)
    }
    
    var documentContextAfterInput: String? {
        guard let textView = textView,
              let selectedRange = textView.selectedTextRange else { return nil }
        
        let end = selectedRange.end
        let endOfDocument = textView.endOfDocument
        
        guard let range = textView.textRange(from: end, to: endOfDocument) else { return nil }
        return textView.text(in: range)
    }
    
    var selectedText: String? {
        guard let textView = textView,
              let selectedRange = textView.selectedTextRange else { return nil }
        
        return textView.text(in: selectedRange)
    }
    
    var documentInputMode: UITextInputMode? {
        return textView?.textInputMode
    }
    
    var documentIdentifier: UUID {
        return UUID()
    }
    
    // MARK: - UIKeyInput Methods
    
    var hasText: Bool {
        return !(textView?.text.isEmpty ?? true)
    }
    
    func insertText(_ text: String) {
        textView?.insertText(text)
    }
    
    func deleteBackward() {
        textView?.deleteBackward()
    }
    
    // MARK: - UITextDocumentProxy Methods
    
    func adjustTextPosition(byCharacterOffset offset: Int) {
        guard let textView = textView,
              let selectedRange = textView.selectedTextRange else { return }
        
        let currentPosition = selectedRange.start
        
        if let newPosition = textView.position(from: currentPosition, offset: offset) {
            textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
        }
    }
    
    func setMarkedText(_ markedText: String, selectedRange: NSRange) {
        guard let textView = textView else { return }
        
        // Remove previous marked text if any
        if !self.markedText.isEmpty {
            let currentText = textView.text ?? ""
            let beforeMarked = String(currentText.prefix(markedTextPosition))
            let afterMarked = String(currentText.dropFirst(markedTextPosition + self.markedText.count))
            textView.text = beforeMarked + afterMarked
            
            // Update cursor position
            if let position = textView.position(from: textView.beginningOfDocument, offset: markedTextPosition) {
                textView.selectedTextRange = textView.textRange(from: position, to: position)
            }
        }
        
        // Store current position and marked text
        if let currentSelectedRange = textView.selectedTextRange {
            let cursorPosition = textView.offset(from: textView.beginningOfDocument, to: currentSelectedRange.start)
            self.markedTextPosition = cursorPosition
            self.markedText = markedText
            
            // Insert the marked text
            let currentText = textView.text ?? ""
            let beforeCursor = String(currentText.prefix(cursorPosition))
            let afterCursor = String(currentText.dropFirst(cursorPosition))
            textView.text = beforeCursor + markedText + afterCursor
            
            // Set cursor position within marked text
            let newCursorOffset = cursorPosition + selectedRange.location
            if let newPosition = textView.position(from: textView.beginningOfDocument, offset: newCursorOffset) {
                textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    func unmarkText() {
        guard let textView = textView else { return }
        
        // Clear our marked text tracking
        self.markedText = ""
        self.markedTextPosition = 0
    }
    
    func documentIdentifier(in textInput: UITextInput) -> UUID? {
        return documentIdentifier
    }
    
    // MARK: - Return Key Type (for keyboard extension compatibility)
    
    var returnKeyType: UIReturnKeyType? {
        return textView?.returnKeyType
    }
}
//
//  UILabel+attributedElements.swift
//  Alamofire
//
//  Created by Francisco Javier Saldivar Rubio on 06/05/22.
//

import Foundation
import UIKit
import Lottie

public protocol UalaAttributedString {
    var word: String { get }
    var delegate: UalaLabelSelectorDelegate? { get }
    
    func getAttributes() -> [NSAttributedString.Key: Any]
    
    @discardableResult
    func setCustomAttribute(_ key: NSAttributedString.Key, value: Any) -> Self
}

public final class UalaLabelAttributedString: UalaAttributedString {
    public var word: String
    public var delegate: UalaLabelSelectorDelegate?
    private var attributes: [NSAttributedString.Key: Any] = [:]
    
    public init(word: String,
                style: LabelStyle,
                delegate: UalaLabelSelectorDelegate?) {
        self.word = word
        self.delegate = delegate
        attributes[NSAttributedString.Key.foregroundColor] = style.textColor
        attributes[NSAttributedString.Key.font] = style.font
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = style.textAlignment
        attributes[NSAttributedString.Key.paragraphStyle] = paragraph
    }
    
    @discardableResult
    public func setCustomAttribute(_ key: NSAttributedString.Key, value: Any) -> Self {
        attributes[key] = value
        return self
    }
    
    public func getAttributes() -> [NSAttributedString.Key: Any] {
        return attributes
    }
}

public protocol UalaLabelSelectorDelegate {
    func onSelected(value: UalaAttributedString)
}

final class UalaLabelTapGesture: UIGestureRecognizer {
    private weak var label: UILabel!
    let elements: [UalaAttributedString]
    init(label: UILabel, elements: [UalaAttributedString]) {
        self.label = label
        self.elements = elements
        super.init(target: nil, action: nil)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        tapLabel()
    }
    
    /// - Parameters:
    ///   - elements: Attributes string of evaluated
    ///   - gesture: Gesture Tap of label
    func tapLabel() {
        guard let text = label.text as NSString? else {
            return
        }

        for element in elements where element.delegate != nil {
            let range = text.range(of: element.word)
            if didTapAttributedTextInLabel(label: label, inRange: range) {
                element.delegate?.onSelected(value: element)
                break
            }
        }
    }

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        let textStorage = NSTextStorage()
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer()
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        textContainer.lineFragmentPadding = 0
        textStorage.setAttributedString(label.attributedText ?? NSAttributedString())
        let range = NSRange(location: 0, length: textStorage.length)
        
        textContainer.size = label.frame.size
        let rect = label.frame
        let usedRect = layoutManager.usedRect(for: textContainer)
        let heightCorrection = (label.frame.height - usedRect.height)/2
        let glyphOriginY = heightCorrection > 0 ? rect.origin.y + heightCorrection : rect.origin.y
        let newOrigin = CGPoint(x: rect.origin.x, y: glyphOriginY)
        
        layoutManager.drawBackground(forGlyphRange: range, at: newOrigin)
        layoutManager.drawGlyphs(forGlyphRange: range, at: newOrigin)
        
        guard textStorage.length > 0 else {
            return false
        }
        
        var correctLocation = location(in: label)
        correctLocation.y -= heightCorrection
        let boundingRect = layoutManager.boundingRect(forGlyphRange: NSRange(location: 0, length: textStorage.length), in: textContainer)
        guard boundingRect.contains(correctLocation) else {
            return false
        }
        
        let index = layoutManager.glyphIndex(for: correctLocation, in: textContainer)
        if index >= targetRange.location && index <= targetRange.location + targetRange.length {
            return true
        }
        return false
    }
}

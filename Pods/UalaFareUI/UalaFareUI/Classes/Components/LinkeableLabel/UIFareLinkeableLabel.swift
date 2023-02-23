//
//  UIFareLinkeableLabel.swift
//  UalaFareUI
//
//  Created by Luis Perez on 21/10/22.
//

import UIKit

final public class UIFareLinkeableLabel: UILabel {
    public typealias Link = (hyperlinkedText: String, link: String)
    // The key is the hyperlinked text, the value is the actual link to redirect the user.
    private var links: [String: String] = [:]
    internal var typography: TypographyStyle?
    public weak var delegate: UIFareLinkeableLabelDelegate?
    
    public func addLink(hyperlinkedText: String, link: String) {
        guard links[hyperlinkedText] == nil else { return }
        
        links[hyperlinkedText] = link

        configureLinkedText()
        addTapGestureRecognizer()
    }
    
    public func addLinks(_ links: [Link]) {
        links.forEach { link in
            self.links[link.hyperlinkedText] = link.link
        }
        
        configureLinkedText()
        addTapGestureRecognizer()
    }
    
    private func configureLinkedText() {
        guard let attributedText = attributedText else { return }
        let linkColor = MainThemeManager.shared.color(for: .primaryDefault)
        let result = NSMutableAttributedString(attributedString: attributedText)
        let attributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                         .underlineColor: linkColor,
                                                         .foregroundColor: linkColor,
                                                         .font: linkFont()]
        for (hyperlinkedText, _) in links {
            let hyperlinkedTextRange = NSString(string: attributedText.string).range(of: hyperlinkedText)
            result.addAttributes(attributes,
                                 range: hyperlinkedTextRange)
        }
        
        self.attributedText = result
    }
    
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTappedLabel(sender:)))
        
        // Remove the tap gesture in case that we already have one assingned.
        self.gestureRecognizers?.removeAll(where: { gesture in
            return gesture is UITapGestureRecognizer
        })
        
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func userDidTappedLabel(sender: UIGestureRecognizer) {
        guard let delegate = self.delegate,
              let attributedTextString = self.attributedText?.string else {
            return
        }
                
        openTappedLinkIfValid(tapPoint: sender.location(in: self),
                              allText: attributedTextString,
                              delegate: delegate)
    }
    
    private func openTappedLinkIfValid(tapPoint: CGPoint, allText: String, delegate: UIFareLinkeableLabelDelegate) {
        for (hyperlinkedText, link) in links {
            let hyperlinkedTextRange = NSString(string: allText).range(of: hyperlinkedText)
            if let hyperlinkedTextRect = rectFor(range: hyperlinkedTextRange),
               hyperlinkedTextRect.contains(tapPoint) {
                delegate.userDidTappedOnLink(link)
                return
            }
        }
    }
    
    // Add the attributes to the string so we can mimic the label and found the location
    private func attributedString() -> NSAttributedString? {
        guard let attributedText = attributedText,
              let typography = self.typography,
              let customFont = UIFont(family: typography.attributes.fontFamily,
                                            weight: typography.attributes.fontWeight,
                                            size: typography.attributes.fontSize) else { return nil }
        
        let mutableString = NSMutableAttributedString(attributedString: attributedText)
        mutableString.addAttribute(.font,
                                   value: customFont,
                                   range: NSRange(location: 0,
                                                  length: attributedText.length))
        mutableString.addAttribute(.kern,
                                   value: typography.attributes.letterSpacing.value,
                                   range: NSRange(location: 0,
                                                  length: attributedText.length))
        
        let paragraphStyle = NSMutableParagraphStyle()
        var lineHeightString = typography.attributes.lineHeight.value
        if typography.attributes.lineHeight.value.hasSuffix("%") {
            lineHeightString.removeLast()
        }
        paragraphStyle.lineSpacing = (lineHeightString.toCGFloat() / 100)
        paragraphStyle.maximumLineHeight = typography.attributes.fontSize.rawValue
        mutableString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        return mutableString
    }
    
    private func rectFor(range: NSRange) -> CGRect? {
        guard let attributedText = attributedString() else { return nil }
                
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: bounds.size)
        var glyphRange = NSRange()

        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0.0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)

        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
    }
    
    private func linkFont() -> UIFont {
        let typography: TypographyStyle
        
        switch self.typography {
        case .bodyMdRegular,
                .bodyMdBold,
                .labelMdRegular,
                .labelMdBold,
                .buttonMdRegular,
                .buttonMdBold,
                .numberMdLight,
                .numberMdRegular,
                .titleMd:
            typography = TypographyStyle.bodyMdBold
            
        case .bodySmRegular,
                .bodySmBold,
                .labelSmRegular,
                .labelSmBold,
                .buttonSmRegular,
                .buttonSmBold,
                .numberSmBold,
                .titleSm,
                .titleXs,
                .headingSm:
            typography = TypographyStyle.bodySmBold
            
        default:
            typography = TypographyStyle.bodyLgBold
        }
        
        guard let customFont = UIFont(family: typography.attributes.fontFamily,
                                      weight: typography.attributes.fontWeight,
                                      size: typography.attributes.fontSize) else {
            return UIFont.systemFont(ofSize: typography.attributes.fontSize.rawValue)
        }
        return customFont
    }
}

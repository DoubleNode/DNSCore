//
//  DNSUILabel.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//
//  Derived from work done by Paulo Silva
//  https://github.com/paulosilva/CustomUIView
//

import UIKit

@IBDesignable open class MEEUILabel: UILabel {

    // MARK: - Private Variables -

    private var style = NSMutableParagraphStyle()

    // MARK: - Public Attributes -

    override open var text: String? {
        didSet {
            let attributeString = NSMutableAttributedString(string: self.text ?? "")
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                         value: self.style,
                                         range: NSRange(location: 0, length: self.text?.count ?? 0))
            self.attributedText = attributeString
        }
    }

    @IBInspectable var zeplinLineHeight: CGFloat {
        get {
            let fontOffset = self.font.lineHeight - self.font.pointSize
            return self.style.lineSpacing + self.font.pointSize + fontOffset
        }
        set {
            let fontOffset = self.font.lineHeight - self.font.pointSize
            self.style.lineSpacing = newValue - self.font.pointSize - fontOffset

            let attributeString = NSMutableAttributedString(string: self.text ?? "")
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                         value: self.style,
                                         range: NSRange(location: 0, length: self.text?.count ?? 0))
            self.attributedText = attributeString
        }
    }
}

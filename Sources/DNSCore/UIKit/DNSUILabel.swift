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

@IBDesignable open class DNSUILabel: UILabel {
    
    // MARK: - Private Variables -

    private var style = NSMutableParagraphStyle()

    // MARK: - Public Attributes -
    
    override open var text: String? {
        didSet {
            let attributeString = NSMutableAttributedString(string: self.text ?? "")
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                         value: self.style,
                                         range: NSMakeRange(0, self.text?.count ?? 0))
            self.attributedText = attributeString
        }
    }
    
    @IBInspectable var lineHeightMultiple: CGFloat {
        get {
            return self.style.lineHeightMultiple
        }
        set {
            self.style.lineHeightMultiple = newValue
            
            let attributeString = NSMutableAttributedString(string: self.text ?? "")
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                         value: self.style,
                                         range: NSMakeRange(0, self.text?.count ?? 0))
            self.attributedText = attributeString
        }
    }

    @IBInspectable var lineSpacing: CGFloat {
        get {
            return self.style.lineSpacing
        }
        set {
            self.style.lineSpacing = newValue

            let attributeString = NSMutableAttributedString(string: self.text ?? "")
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                         value: self.style,
                                         range: NSMakeRange(0, self.text?.count ?? 0))
            self.attributedText = attributeString
        }
    }
}

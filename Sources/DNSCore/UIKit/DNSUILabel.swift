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

    privare var style = NSMutableParagraphStyle()

    // MARK: - Public Attributes -
    
    open var text: String? {
        didSet {
            let attributeString = NSMutableAttributedString(string: self.text)
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: self.style, range: NSMakeRange(0, self.text?.count))
            self.attributedText = attributeString
        }
    }
    
    @IBInspectable var lineSpacing: CGFloat {
        get {
            return self.style.lineSpacing
        }
        set {
            self.style.lineSpacing = newValue

            let attributeString = NSMutableAttributedString(string: self.text)
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: self.style, range: NSMakeRange(0, self.text?.count))
            self.attributedText = attributeString
        }
    }
}

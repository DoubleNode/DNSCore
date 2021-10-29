//
//  DNSThemeLabelStyle.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSThemeLabelStyle: DNSThemeViewStyle {
    public var color: DNSUIColor
    public var font: DNSUIFont
    public var paragraphStyle: NSMutableParagraphStyle
    
    public init(color: DNSUIColor = DNSUIColor(UIColor.label),
                font: DNSUIFont = DNSUIFont(),
                paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle(),
                shadow: DNSUIShadow = DNSUIShadow(),
                backgroundColor: DNSUIColor = DNSUIColor(UIColor.systemBackground),
                border: DNSUIBorder = DNSUIBorder(),
                tintColor: DNSUIColor = DNSUIColor(UIColor.systemBlue)) {
        self.color = color
        self.font = font
        self.paragraphStyle = paragraphStyle
        super.init(backgroundColor: backgroundColor,
                   border: border,
                   shadow: shadow,
                   tintColor: tintColor)
    }
}

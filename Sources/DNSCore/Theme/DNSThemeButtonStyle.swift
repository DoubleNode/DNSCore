//
//  DNSThemeButtonStyle.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSThemeButtonStyle: DNSThemeViewStyle {
    public var titleColor: DNSUIColor
    public var titleFont: DNSUIFont
    public var titleShadowColor: DNSUIColor
    
    public init(titleColor: DNSUIColor = DNSUIColor(UIColor.label),
                titleFont: DNSUIFont = DNSUIFont(),
                titleShadowColor: DNSUIColor = DNSUIColor(UIColor.systemGray),
                backgroundColor: DNSUIColor = DNSUIColor(UIColor.systemBackground),
                border: DNSUIBorder = DNSUIBorder(),
                shadow: DNSUIShadow = DNSUIShadow(),
                tintColor: DNSUIColor = DNSUIColor(UIColor.systemBlue)) {
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.titleShadowColor = titleShadowColor
        super.init(backgroundColor: backgroundColor,
                   border: border,
                   shadow: shadow,
                   tintColor: tintColor)
    }
}

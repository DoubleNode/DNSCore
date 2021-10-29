//
//  DNSThemeButtonStyle.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSThemeButtonStyle: DNSThemeViewStyle {
    public var subtitleColor: DNSUIColor
    public var subtitleFont: DNSUIFont
    public var subtitleShadow: DNSUIShadow
    public var titleColor: DNSUIColor
    public var titleFont: DNSUIFont
    public var titleShadow: DNSUIShadow
    
    public init(titleColor: DNSUIColor = DNSUIColor.Base.Button.title,
                titleFont: DNSUIFont = DNSUIFont.Base.Button.title,
                titleShadow: DNSUIShadow = DNSUIShadow.Base.Button.title,
                subtitleColor: DNSUIColor = DNSUIColor.Base.Button.subtitle,
                subtitleFont: DNSUIFont = DNSUIFont.Base.Button.subtitle,
                subtitleShadow: DNSUIShadow = DNSUIShadow.Base.Button.subtitle,
                backgroundColor: DNSUIColor = DNSUIColor.Base.Button.background,
                border: DNSUIBorder = DNSUIBorder.Base.button,
                shadow: DNSUIShadow = DNSUIShadow.Base.button,
                tintColor: DNSUIColor = DNSUIColor.Base.Button.tint) {
        self.subtitleColor = subtitleColor
        self.subtitleFont = subtitleFont
        self.subtitleShadow = subtitleShadow
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.titleShadow = titleShadow
        super.init(backgroundColor: backgroundColor,
                   border: border,
                   shadow: shadow,
                   tintColor: tintColor)
    }
}

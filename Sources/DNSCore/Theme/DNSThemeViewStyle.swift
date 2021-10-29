//
//  DNSThemeViewStyle.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSThemeViewStyle: DNSThemeStyle {
    public var backgroundColor: DNSUIColor
    public var border: DNSUIBorder
    public var shadow: DNSUIShadow
    public var tintColor: DNSUIColor
    
    public init(backgroundColor: DNSUIColor = DNSUIColor(UIColor.systemBackground),
                border: DNSUIBorder = DNSUIBorder(),
                shadow: DNSUIShadow = DNSUIShadow(),
                tintColor: DNSUIColor = DNSUIColor(UIColor.systemBlue)) {
        self.backgroundColor = backgroundColor
        self.border = border
        self.shadow = shadow
        self.tintColor = tintColor
        super.init()
    }
}

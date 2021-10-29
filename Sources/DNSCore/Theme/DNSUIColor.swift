//
//  DNSUIColor.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIColor {
    public var disabled: UIColor
    public var focused: UIColor
    public var highlighted: UIColor
    public var normal: UIColor
    public var selected: UIColor
    
    required public init(_ normal: UIColor,
                         disabled: UIColor? = nil,
                         focused: UIColor? = nil,
                         highlighted: UIColor? = nil,
                         selected: UIColor? = nil) {
        self.normal = normal
        self.disabled = disabled ?? normal
        self.focused = focused ?? normal
        self.highlighted = highlighted ?? normal
        self.selected = selected ?? normal
    }
}

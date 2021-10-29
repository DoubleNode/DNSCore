//
//  DNSUIBorder.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIBorder {
    public var color: DNSUIColor
    public var cornerRadius: Double
    public var cornerRadiusMulti: Bool
    public var cornerTopLeftRadius: Double
    public var cornerTopRightRadius: Double
    public var cornerBottomLeftRadius: Double
    public var cornerBottomRightRadius: Double
    public var width: Double
    
    required public init(color: DNSUIColor = DNSUIColor(UIColor.clear),
                         cornerRadius: Double = 0,
                         cornerRadiusMulti: Bool = false,
                         cornerTopLeftRadius: Double = 0,
                         cornerTopRightRadius: Double = 0,
                         cornerBottomLeftRadius: Double = 0,
                         cornerBottomRightRadius: Double = 0,
                         width: Double = 0) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.cornerRadiusMulti = cornerRadiusMulti
        self.cornerTopLeftRadius = cornerTopLeftRadius
        self.cornerTopRightRadius = cornerTopRightRadius
        self.cornerBottomLeftRadius = cornerBottomLeftRadius
        self.cornerBottomRightRadius = cornerBottomRightRadius
        self.width = width
    }
}

//
//  DNSUIShadow.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIShadow {
    public var color: DNSUIColor
    public var offset: CGSize
    public var opacity: Float
    public var radius: Double
    
    required public init(color: DNSUIColor = DNSUIColor.Base.shadow,
                         offset: CGSize = CGSize(),
                         opacity: Float = 0,
                         radius: Double = 0) {
        self.color = color
        self.offset = offset
        self.opacity = opacity
        self.radius = radius
    }
}
public extension DNSUIShadow {
    enum Base {
        public static var button = DNSUIShadow(color: DNSUIColor.Base.Button.shadow)
        public enum Button {
            public static var subtitle = DNSUIShadow(color: DNSUIColor.Base.Button.subtitleShadow)
            public static var title = DNSUIShadow(color: DNSUIColor.Base.Button.titleShadow)
        }
    }
}

//
//  DNSUIFont.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIFont {
    public var fontName: String
    public var size: Double
    
    required public init(fontName: String = "System",
                         size: Double = 15) {
        self.fontName = fontName
        self.size = size
    }
}
public extension DNSUIFont {
    enum Base {
        public enum Button {
            public static var subtitle = DNSUIFont(fontName: "System", size: 12)
            public static var title = DNSUIFont(fontName: "System", size: 15)
        }
    }
}

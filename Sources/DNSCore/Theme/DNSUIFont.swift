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
                         size: Double = 0) {
        self.fontName = fontName
        self.size = size
    }
}

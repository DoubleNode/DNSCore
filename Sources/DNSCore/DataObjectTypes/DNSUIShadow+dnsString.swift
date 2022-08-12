//
//  DNSUIShadow+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIShadow {
    convenience init(with string: String) {
        var color = DNSUIColor(with: string)
        var offset = CGSizeZero
        var opacity = Float(0)
        var radius = Double(0)
        if string.contains("|") {
            let strings = string.components(separatedBy: "|")
            if strings.count > 0 {
                color = Self.xlt.dnscolor(from: strings[0]) ?? color
            }
            if strings.count > 1 {
                offset = Self.xlt.cgsize(from: strings[1]) ?? offset
            }
            if strings.count > 2 {
                opacity = Self.xlt.float(from: strings[2]) ?? opacity
            }
            if strings.count > 3 {
                radius = Self.xlt.double(from: strings[3]) ?? radius
            }
        }
        self.init(color: color, offset: offset, opacity: opacity, radius: radius)
    }
}

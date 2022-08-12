//
//  DNSUIBorder+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIBorder {
    convenience init(with string: String) {
        var color = DNSUIColor(with: string)
        var width = Double(0)
        var cornerRadius = Double(0)
        if string.contains("|") {
            let strings = string.components(separatedBy: "|")
            if strings.count > 0 {
                color = Self.xlt.dnscolor(from: strings[0]) ?? color
            }
            if strings.count > 1 {
                width = Self.xlt.double(from: strings[1]) ?? width
            }
            if strings.count > 2 {
                cornerRadius = Self.xlt.double(from: strings[2]) ?? cornerRadius
            }
        }
        self.init(color: color, cornerRadius: cornerRadius, width: width)
    }
}

//
//  DNSUIShadow+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIShadow {
    convenience init?(with string: String) {
        var color: DNSUIColor?
        var offset: CGSize?
        var opacity: Float?
        var radius: Double?
        guard string.contains("|") else { return nil }
        let strings = string.components(separatedBy: "|")
        if strings.isEmpty { return nil }
        if strings.count >= 1 {
            color = Self.xlt.dnscolor(from: strings[0])
        }
        guard let color else { return nil }
        if strings.count >= 2 {
            offset = Self.xlt.cgsize(from: strings[1])
        }
        guard let offset else {
            self.init(color: color)
            return
        }
        if strings.count >= 3 {
            opacity = Self.xlt.float(from: strings[2])
        }
        guard let opacity else {
            self.init(color: color, offset: offset)
            return
        }
        if strings.count >= 4 {
            radius = Self.xlt.double(from: strings[3])
        }
        guard let radius else {
            self.init(color: color, offset: offset, opacity: opacity)
            return
        }
        self.init(color: color, offset: offset, opacity: opacity, radius: radius)
    }
}

//
//  DNSUIStrikeThru+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIStrikeThru {
    convenience init?(with string: String) {
        var color: DNSUIColor?
        var enabled: DNSUIEnabled?
        var style: NSUnderlineStyle?
        guard string.contains("|") else { return nil }
        let strings = string.components(separatedBy: "|")
        if strings.isEmpty { return nil }
        if strings.count >= 1 {
            color = Self.xlt.dnscolor(from: strings[0])
        }
        guard let color else { return nil }
        if strings.count >= 2 {
            enabled = Self.xlt.dnsenabled(from: strings[1])
        }
        guard let enabled else {
            self.init(color: color)
            return
        }
        if strings.count >= 3 {
            if let styleInt = Self.xlt.int(from: strings[2]) {
                style = NSUnderlineStyle(rawValue: styleInt)
            }
        }
        guard let style else {
            self.init(color: color, enabled: enabled)
            return
        }
        self.init(color: color, enabled: enabled, style: style)
    }
}

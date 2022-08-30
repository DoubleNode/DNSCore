//
//  DNSUIStrikeThru+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIStrikeThru {
    convenience init(from data: DNSDataDictionary) {
        let color = Self.xlt.dnscolor(from: data[Self.field(.color)] as Any?) ?? DNSUIStrikeThru.baseColor()
        let enabled = Self.xlt.dnsenabled(from: data[Self.field(.enabled)] as Any?) ?? DNSUIEnabled(false)
        var style = NSUnderlineStyle.single
        if let styleInt = Self.xlt.int(from: data[Self.field(.style)] as Any?) {
            style = NSUnderlineStyle(rawValue: styleInt)
        }
        self.init(color: color, enabled: enabled, style: style)
    }
    var asDictionary: DNSDataDictionary {
        let retval: DNSDataDictionary = [
            Self.field(.color): self.color.asDictionary,
            Self.field(.enabled): self.enabled.asDictionary,
            Self.field(.style): self.style.rawValue,
        ]
        return retval
    }
}

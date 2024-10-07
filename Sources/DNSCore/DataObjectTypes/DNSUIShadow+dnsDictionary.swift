//
//  DNSUIShadow+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIShadow {
    convenience init(from data: DNSDataDictionary) {
        let color = Self.xlt.dnscolor(from: data[Self.field(.color)] as Any?) ?? DNSUIBorder.baseBorderColor()
        let offset = Self.xlt.cgsize(from: data[Self.field(.offset)] as Any?) ?? .zero
        let opacity = Self.xlt.float(from: data[Self.field(.opacity)] as Any?) ?? 0
        let radius = Self.xlt.double(from: data[Self.field(.radius)] as Any?) ?? 0
        self.init(color: color, offset: offset, opacity: opacity, radius: radius)
    }
    var asDictionary: DNSDataDictionary {
        let retval: DNSDataDictionary = [
            Self.field(.color): self.color.asDictionary,
            Self.field(.offset): self.offset.asDictionary,
            Self.field(.opacity): Float(self.opacity),
            Self.field(.radius): Double(self.radius),
        ]
        return retval
    }
}

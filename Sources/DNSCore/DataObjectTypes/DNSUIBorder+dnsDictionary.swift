//
//  DNSUIBorder+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIBorder {
    convenience init(from data: DNSDataDictionary) {
        let color = Self.xlt.dnscolor(from: data[Self.field(.color)] as Any?) ?? DNSUIBorder.baseBorderColor()
        let cornerRadius = Self.xlt.double(from: data[Self.field(.cornerRadius)] as Any?) ?? 0
        let cornerRadiusMulti = Self.xlt.bool(from: data[Self.field(.cornerRadiusMulti)] as Any?) ?? false
        let cornerTopLeftRadius = Self.xlt.double(from: data[Self.field(.cornerTopLeftRadius)] as Any?) ?? 0
        let cornerTopRightRadius = Self.xlt.double(from: data[Self.field(.cornerTopRightRadius)] as Any?) ?? 0
        let cornerBottomLeftRadius = Self.xlt.double(from: data[Self.field(.cornerBottomLeftRadius)] as Any?) ?? 0
        let cornerBottomRightRadius = Self.xlt.double(from: data[Self.field(.cornerBottomRightRadius)] as Any?) ?? 0
        let width = Self.xlt.double(from: data[Self.field(.width)] as Any?) ?? 0
        self.init(color: color, cornerRadius: cornerRadius, cornerRadiusMulti: cornerRadiusMulti,
                  cornerTopLeftRadius: cornerTopLeftRadius, cornerTopRightRadius: cornerTopRightRadius,
                  cornerBottomLeftRadius: cornerBottomLeftRadius,
                  cornerBottomRightRadius: cornerBottomRightRadius, width: width)
    }
    var asDictionary: DNSDataDictionary {
        let retval: DNSDataDictionary = [
            Self.field(.color): self.color.asDictionary,
            Self.field(.cornerRadius): Double(self.cornerRadius),
            Self.field(.cornerRadiusMulti): Bool(self.cornerRadiusMulti),
            Self.field(.cornerTopLeftRadius): Double(self.cornerTopLeftRadius),
            Self.field(.cornerTopRightRadius): Double(self.cornerTopRightRadius),
            Self.field(.cornerBottomLeftRadius): Double(self.cornerBottomLeftRadius),
            Self.field(.cornerBottomRightRadius): Double(self.cornerBottomRightRadius),
            Self.field(.width): Double(self.width),
        ]
        return retval
    }
}

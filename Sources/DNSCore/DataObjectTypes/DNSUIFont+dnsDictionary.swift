//
//  DNSUIFont+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIFont {
    convenience init?(from data: DNSDataDictionary) {
        let disabled = Self.xlt.font(from: data[Self.field(.disabled)] as Any?)
        let focused = Self.xlt.font(from: data[Self.field(.focused)] as Any?)
        let highlighted = Self.xlt.font(from: data[Self.field(.highlighted)] as Any?)
        let selected = Self.xlt.font(from: data[Self.field(.selected)] as Any?)
        guard let normal = Self.xlt.font(from: data[Self.field(.normal)] as Any?) else {
            guard let normal = Self.xlt.font(from: data as Any?) else { return nil }
            self.init(normal)
            return
        }
        self.init(normal, disabled: disabled, focused: focused,
                  highlighted: highlighted, selected: selected)
    }
    var asDictionary: DNSDataDictionary {
        let retval: DNSDataDictionary = [
            Self.field(.normal): self.normal.asDictionary,
            Self.field(.disabled): self.disabled.asDictionary,
            Self.field(.focused): self.focused.asDictionary,
            Self.field(.highlighted): self.highlighted.asDictionary,
            Self.field(.selected): self.selected.asDictionary,
        ]
        return retval
    }
}

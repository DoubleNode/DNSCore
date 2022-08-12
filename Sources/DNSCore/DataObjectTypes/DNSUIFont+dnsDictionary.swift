//
//  DNSUIFont+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIFont {
    convenience init(from data: DNSDataDictionary) {
        if let normal = Self.xlt.font(from: data[Self.field(.normal)] as Any?) {
            let disabled = Self.xlt.font(from: data[Self.field(.disabled)] as Any?) ?? UIFont()
            let focused = Self.xlt.font(from: data[Self.field(.focused)] as Any?) ?? UIFont()
            let highlighted = Self.xlt.font(from: data[Self.field(.highlighted)] as Any?) ?? UIFont()
            let selected = Self.xlt.font(from: data[Self.field(.selected)] as Any?) ?? UIFont()
            self.init(normal, disabled: disabled, focused: focused,
                      highlighted: highlighted, selected: selected)
        } else {
            let normal = Self.xlt.font(from: data as Any?) ?? UIFont()
            self.init(normal)
        }
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

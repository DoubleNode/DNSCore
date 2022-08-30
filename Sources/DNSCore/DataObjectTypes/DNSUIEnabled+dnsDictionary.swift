//
//  DNSUIEnabled+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIEnabled {
    convenience init?(from data: DNSDataDictionary) {
        let disabled = Self.xlt.bool(from: data[Self.field(.disabled)] as Any?)
        let focused = Self.xlt.bool(from: data[Self.field(.focused)] as Any?)
        let highlighted = Self.xlt.bool(from: data[Self.field(.highlighted)] as Any?)
        let selected = Self.xlt.bool(from: data[Self.field(.selected)] as Any?)
        guard let normal = Self.xlt.bool(from: data[Self.field(.normal)] as Any?) else {
            guard let normal = Self.xlt.bool(from: data as Any?) else { return nil }
            self.init(normal)
            return
        }
        self.init(normal, disabled: disabled, focused: focused,
                  highlighted: highlighted, selected: selected)
    }
    var asDictionary: DNSDataDictionary {
        if self.disabled == self.normal &&
            self.focused == self.normal &&
            self.highlighted == self.normal &&
            self.selected == self.normal {
            let retval: DNSDataDictionary = [
                Self.field(.normal): self.normal,
            ]
            return retval
        }
        let retval: DNSDataDictionary = [
            Self.field(.normal): self.normal,
            Self.field(.disabled): self.disabled,
            Self.field(.focused): self.focused,
            Self.field(.highlighted): self.highlighted,
            Self.field(.selected): self.selected,
        ]
        return retval
    }
}

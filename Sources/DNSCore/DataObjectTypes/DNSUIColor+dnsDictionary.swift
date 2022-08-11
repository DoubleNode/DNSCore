//
//  DNSUIColor+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIColor {
    convenience init(from data: DNSDataDictionary) {
        let normal = Self.xlt.color(from: data[Self.field(.normal)] as Any?) ?? UIColor()
        let disabled = Self.xlt.color(from: data[Self.field(.disabled)] as Any?) ?? UIColor()
        let focused = Self.xlt.color(from: data[Self.field(.focused)] as Any?) ?? UIColor()
        let highlighted = Self.xlt.color(from: data[Self.field(.highlighted)] as Any?) ?? UIColor()
        let selected = Self.xlt.color(from: data[Self.field(.selected)] as Any?) ?? UIColor()
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
//open class DNSUIColor: Hashable {
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(disabled)
//        hasher.combine(focused)
//        hasher.combine(highlighted)
//        hasher.combine(normal)
//        hasher.combine(selected)
//    }
//    public static func == (lhs: DNSUIColor, rhs: DNSUIColor) -> Bool {
//        guard lhs.disabled == rhs.disabled else { return false }
//        guard lhs.focused == rhs.focused else { return false }
//        guard lhs.highlighted == rhs.highlighted else { return false }
//        guard lhs.normal == rhs.normal else { return false }
//        guard lhs.selected == rhs.selected else { return false }
//        return true
//    }
//    
//    public var disabled: UIColor
//    public var focused: UIColor
//    public var highlighted: UIColor
//    public var normal: UIColor
//    public var selected: UIColor
//    
//    required public init(_ normal: UIColor,
//                         disabled: UIColor? = nil,
//                         focused: UIColor? = nil,
//                         highlighted: UIColor? = nil,
//                         selected: UIColor? = nil) {
//        self.normal = normal
//        self.disabled = disabled ?? normal
//        self.focused = focused ?? normal
//        self.highlighted = highlighted ?? normal
//        self.selected = selected ?? normal
//    }
//}

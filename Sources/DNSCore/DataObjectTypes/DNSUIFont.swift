//
//  DNSUIFont.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIFont: Hashable {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    internal static func field(_ from: CodingKeys) -> String { return from.rawValue }
    enum CodingKeys: String, CodingKey {
        case disabled, focused, highlighted, normal, selected
    }

    public var disabled: UIFont
    public var focused: UIFont
    public var highlighted: UIFont
    public var normal: UIFont
    public var selected: UIFont
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(disabled)
        hasher.combine(focused)
        hasher.combine(highlighted)
        hasher.combine(normal)
        hasher.combine(selected)
    }
    public static func == (lhs: DNSUIFont, rhs: DNSUIFont) -> Bool {
        guard lhs.disabled == rhs.disabled else { return false }
        guard lhs.focused == rhs.focused else { return false }
        guard lhs.highlighted == rhs.highlighted else { return false }
        guard lhs.normal == rhs.normal else { return false }
        guard lhs.selected == rhs.selected else { return false }
        return true
    }
    
    required public init(_ normal: UIFont,
                         disabled: UIFont? = nil,
                         focused: UIFont? = nil,
                         highlighted: UIFont? = nil,
                         selected: UIFont? = nil) {
        self.normal = normal
        self.disabled = disabled ?? normal
        self.focused = focused ?? normal
        self.highlighted = highlighted ?? normal
        self.selected = selected ?? normal
    }
}

//
//  DNSUIEnabled.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIEnabled: Hashable, Codable, NSCopying {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    internal static func field(_ from: CodingKeys) -> String { return from.rawValue }
    enum CodingKeys: String, CodingKey {
        case disabled, focused, highlighted, normal, selected
    }
    
    public var disabled: Bool
    public var focused: Bool
    public var highlighted: Bool
    public var normal: Bool
    public var selected: Bool
    
    required public init(_ normal: Bool,
                         disabled: Bool? = nil,
                         focused: Bool? = nil,
                         highlighted: Bool? = nil,
                         selected: Bool? = nil) {
        self.normal = normal
        self.disabled = disabled ?? normal
        self.focused = focused ?? normal
        self.highlighted = highlighted ?? normal
        self.selected = selected ?? normal
    }
    
    // Codable protocol methods
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.normal = try container.decode(Bool.self, forKey: .normal)
        self.disabled = try container.decode(Bool.self, forKey: .disabled)
        self.focused = try container.decode(Bool.self, forKey: .focused)
        self.highlighted = try container.decode(Bool.self, forKey: .highlighted)
        self.selected = try container.decode(Bool.self, forKey: .selected)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.normal, forKey: .normal)
        try container.encode(self.disabled, forKey: .disabled)
        try container.encode(self.focused, forKey: .focused)
        try container.encode(self.highlighted, forKey: .highlighted)
        try container.encode(self.selected, forKey: .selected)
    }
    
    // Equatable protocol methods
    static public func ==(lhs: DNSUIEnabled, rhs: DNSUIEnabled) -> Bool {
        guard lhs.disabled == rhs.disabled else { return false }
        guard lhs.focused == rhs.focused else { return false }
        guard lhs.highlighted == rhs.highlighted else { return false }
        guard lhs.normal == rhs.normal else { return false }
        guard lhs.selected == rhs.selected else { return false }
        return true
    }
    
    // Hashable protocol methods
    public func hash(into hasher: inout Hasher) {
        hasher.combine(disabled)
        hasher.combine(focused)
        hasher.combine(highlighted)
        hasher.combine(normal)
        hasher.combine(selected)
    }

    // NSCopying protocol methods
    public func copy(with zone: NSZone? = nil) -> Any {
        let newDisabled = self.disabled
        let newFocused = self.focused
        let newHighlighted = self.highlighted
        let newNormal = self.normal
        let newSelected = self.selected
        let copy = DNSUIEnabled(newNormal, disabled: newDisabled, focused: newFocused,
                                highlighted: newHighlighted, selected: newSelected)
        return copy
    }
}

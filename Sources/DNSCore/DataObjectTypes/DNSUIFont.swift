//
//  DNSUIFont.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIFont: Hashable, Codable, NSCopying {
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

    // Codable protocol methods
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let normalContainer = try container
            .nestedContainer(keyedBy: UIFont.ExtensionCodingKeys.self, forKey: .normal)
        let disabledContainer = try container
            .nestedContainer(keyedBy: UIFont.ExtensionCodingKeys.self, forKey: .disabled)
        let focusedContainer = try container
            .nestedContainer(keyedBy: UIFont.ExtensionCodingKeys.self, forKey: .focused)
        let highlightedContainer = try container
            .nestedContainer(keyedBy: UIFont.ExtensionCodingKeys.self, forKey: .highlighted)
        let selectedContainer = try container
            .nestedContainer(keyedBy: UIFont.ExtensionCodingKeys.self, forKey: .selected)

        self.normal = try UIFont.decode(from: normalContainer) ?? UIFont()
        self.disabled = try UIFont.decode(from: disabledContainer) ?? UIFont()
        self.focused = try UIFont.decode(from: focusedContainer) ?? UIFont()
        self.highlighted = try UIFont.decode(from: highlightedContainer) ?? UIFont()
        self.selected = try UIFont.decode(from: selectedContainer) ?? UIFont()
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let normalContainer = container
            .nestedContainer(keyedBy: UIFont.ExtensionCodingKeys.self, forKey: .normal)
        let disabledContainer = container
            .nestedContainer(keyedBy: UIFont.ExtensionCodingKeys.self, forKey: .disabled)
        let focusedContainer = container
            .nestedContainer(keyedBy: UIFont.ExtensionCodingKeys.self, forKey: .focused)
        let highlightedContainer = container
            .nestedContainer(keyedBy: UIFont.ExtensionCodingKeys.self, forKey: .highlighted)
        let selectedContainer = container
            .nestedContainer(keyedBy: UIFont.ExtensionCodingKeys.self, forKey: .selected)

        try self.normal.encode(to: normalContainer)
        try self.disabled.encode(to: disabledContainer)
        try self.focused.encode(to: focusedContainer)
        try self.highlighted.encode(to: highlightedContainer)
        try self.selected.encode(to: selectedContainer)
    }

    // Equatable protocol methods
    static public func ==(lhs: DNSUIFont, rhs: DNSUIFont) -> Bool {
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
        let copy = DNSUIFont(newNormal, disabled: newDisabled, focused: newFocused,
                             highlighted: newHighlighted, selected: newSelected)
        return copy
    }
}

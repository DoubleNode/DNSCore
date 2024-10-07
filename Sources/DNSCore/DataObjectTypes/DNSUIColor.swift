//
//  DNSUIColor.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIColor: Hashable, Codable, NSCopying {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    internal static func field(_ from: CodingKeys) -> String { return from.rawValue }
    enum CodingKeys: String, CodingKey {
        case disabled, focused, highlighted, normal, selected
    }

    public var disabled: UIColor
    public var focused: UIColor
    public var highlighted: UIColor
    public var normal: UIColor
    public var selected: UIColor

    required public init(_ normal: UIColor,
                         disabled: UIColor? = nil,
                         focused: UIColor? = nil,
                         highlighted: UIColor? = nil,
                         selected: UIColor? = nil) {
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
            .nestedContainer(keyedBy: UIColor.ExtensionCodingKeys.self, forKey: .normal)
        let disabledContainer = try container
            .nestedContainer(keyedBy: UIColor.ExtensionCodingKeys.self, forKey: .disabled)
        let focusedContainer = try container
            .nestedContainer(keyedBy: UIColor.ExtensionCodingKeys.self, forKey: .focused)
        let highlightedContainer = try container
            .nestedContainer(keyedBy: UIColor.ExtensionCodingKeys.self, forKey: .highlighted)
        let selectedContainer = try container
            .nestedContainer(keyedBy: UIColor.ExtensionCodingKeys.self, forKey: .selected)

        self.normal = try UIColor.decode(from: normalContainer) ?? UIColor()
        self.disabled = try UIColor.decode(from: disabledContainer) ?? UIColor()
        self.focused = try UIColor.decode(from: focusedContainer) ?? UIColor()
        self.highlighted = try UIColor.decode(from: highlightedContainer) ?? UIColor()
        self.selected = try UIColor.decode(from: selectedContainer) ?? UIColor()
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let normalContainer = container
            .nestedContainer(keyedBy: UIColor.ExtensionCodingKeys.self, forKey: .normal)
        let disabledContainer = container
            .nestedContainer(keyedBy: UIColor.ExtensionCodingKeys.self, forKey: .disabled)
        let focusedContainer = container
            .nestedContainer(keyedBy: UIColor.ExtensionCodingKeys.self, forKey: .focused)
        let highlightedContainer = container
            .nestedContainer(keyedBy: UIColor.ExtensionCodingKeys.self, forKey: .highlighted)
        let selectedContainer = container
            .nestedContainer(keyedBy: UIColor.ExtensionCodingKeys.self, forKey: .selected)

        try self.normal.encode(to: normalContainer)
        try self.disabled.encode(to: disabledContainer)
        try self.focused.encode(to: focusedContainer)
        try self.highlighted.encode(to: highlightedContainer)
        try self.selected.encode(to: selectedContainer)
    }

    // Equatable protocol methods
    static public func == (lhs: DNSUIColor, rhs: DNSUIColor) -> Bool {
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
        let copy = DNSUIColor(newNormal, disabled: newDisabled, focused: newFocused,
                              highlighted: newHighlighted, selected: newSelected)
        return copy
    }
}

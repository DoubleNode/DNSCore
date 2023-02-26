//
//  DNSUIStrikeThru.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIStrikeThru: Hashable, Codable, NSCopying {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    internal static func field(_ from: CodingKeys) -> String { return from.rawValue }
    enum CodingKeys: String, CodingKey {
        case color, enabled, style
    }

    public var color: DNSUIColor
    public var enabled: DNSUIEnabled
    public var style: NSUnderlineStyle
    
    open class func baseColor() -> DNSUIColor {
        return DNSUIColor(UIColor.clear)
    }

    required public init(color: DNSUIColor,
                         enabled: DNSUIEnabled = DNSUIEnabled(false),
                         style: NSUnderlineStyle = .single) {
        self.color = color
        self.enabled = enabled
        self.style = style
    }

    // Codable protocol methods
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.color = try container.decode(DNSUIColor.self, forKey: .color)
        self.enabled = try container.decode(DNSUIEnabled.self, forKey: .enabled)
        let styleInt = try container.decode(Int.self, forKey: .style)
        self.style = NSUnderlineStyle(rawValue: styleInt)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.color, forKey: .color)
        try container.encode(self.enabled, forKey: .enabled)
        try container.encode(self.style.rawValue, forKey: .style)
    }

    // Equatable protocol methods
    static public func ==(lhs: DNSUIStrikeThru, rhs: DNSUIStrikeThru) -> Bool {
        guard lhs.color == rhs.color else { return false }
        guard lhs.enabled == rhs.enabled else { return false }
        guard lhs.style == rhs.style else { return false }
        return true
    }

    // Hashable protocol methods
    public func hash(into hasher: inout Hasher) {
        hasher.combine(color)
        hasher.combine(enabled)
        hasher.combine(style.rawValue)
    }

    // NSCopying protocol methods
    public func copy(with zone: NSZone? = nil) -> Any {
        let newColor = self.color
        let newEnabled = self.enabled
        let newStyle = self.style
        let copy = DNSUIStrikeThru(color: newColor, enabled: newEnabled, style: newStyle)
        return copy
    }
}

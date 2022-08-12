//
//  DNSUIShadow.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIShadow: Hashable, Codable, NSCopying {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    internal static func field(_ from: CodingKeys) -> String { return from.rawValue }
    enum CodingKeys: String, CodingKey {
        case color, offset, opacity, radius
    }

    public var color: DNSUIColor
    public var offset: CGSize
    public var opacity: Float
    public var radius: Double
    
    open class func baseShadowColor() -> DNSUIColor {
        return DNSUIColor(UIColor.clear)
    }

    required public init(color: DNSUIColor = DNSUIShadow.baseShadowColor(),
                         offset: CGSize = CGSize(),
                         opacity: Float = 0,
                         radius: Double = 0) {
        self.color = color
        self.offset = offset
        self.opacity = opacity
        self.radius = radius
    }

    // Codable protocol methods
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.color = try container.decode(DNSUIColor.self, forKey: .color)
        self.offset = try container.decode(CGSize.self, forKey: .offset)
        self.opacity = try container.decode(Float.self, forKey: .opacity)
        self.radius = try container.decode(Double.self, forKey: .radius)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.color, forKey: .color)
        try container.encode(self.offset, forKey: .offset)
        try container.encode(self.opacity, forKey: .opacity)
        try container.encode(self.radius, forKey: .radius)
    }

    // Equatable protocol methods
    public static func == (lhs: DNSUIShadow, rhs: DNSUIShadow) -> Bool {
        guard lhs.color == rhs.color else { return false }
        guard lhs.offset == rhs.offset else { return false }
        guard lhs.opacity == rhs.opacity else { return false }
        guard lhs.radius == rhs.radius else { return false }
        return true
    }

    // Hashable protocol methods
    public func hash(into hasher: inout Hasher) {
        hasher.combine(color)
        hasher.combine(offset.width)
        hasher.combine(offset.height)
        hasher.combine(opacity)
        hasher.combine(radius)
    }

    // NSCopying protocol methods
    public func copy(with zone: NSZone? = nil) -> Any {
        let newColor = self.color
        let newOffset = self.offset
        let copy = DNSUIShadow(color: newColor, offset: newOffset, opacity: opacity, radius: radius)
        return copy
    }
}

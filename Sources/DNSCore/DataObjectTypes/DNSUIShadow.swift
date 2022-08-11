//
//  DNSUIShadow.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIShadow: Hashable {
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
    public func hash(into hasher: inout Hasher) {
        hasher.combine(color)
        hasher.combine(offset.width)
        hasher.combine(offset.height)
        hasher.combine(opacity)
        hasher.combine(radius)
    }
    public static func == (lhs: DNSUIShadow, rhs: DNSUIShadow) -> Bool {
        guard lhs.color == rhs.color else { return false }
        guard lhs.offset == rhs.offset else { return false }
        guard lhs.opacity == rhs.opacity else { return false }
        guard lhs.radius == rhs.radius else { return false }
        return true
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
}

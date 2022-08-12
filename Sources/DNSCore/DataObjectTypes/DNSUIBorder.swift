//
//  DNSUIBorder.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIBorder: Hashable, Codable, NSCopying {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    internal static func field(_ from: CodingKeys) -> String { return from.rawValue }
    enum CodingKeys: String, CodingKey {
        case color, cornerRadius, cornerRadiusMulti, cornerTopLeftRadius, cornerTopRightRadius
        case cornerBottomLeftRadius, cornerBottomRightRadius, width
    }
    
    public var color: DNSUIColor
    public var cornerRadius: Double
    public var cornerRadiusMulti: Bool
    public var cornerTopLeftRadius: Double
    public var cornerTopRightRadius: Double
    public var cornerBottomLeftRadius: Double
    public var cornerBottomRightRadius: Double
    public var width: Double
    
    open class func baseBorderColor() -> DNSUIColor {
        return DNSUIColor(UIColor.clear)
    }
    required public init(color: DNSUIColor = DNSUIBorder.baseBorderColor(),
                         cornerRadius: Double = 0,
                         cornerRadiusMulti: Bool = false,
                         cornerTopLeftRadius: Double = 0,
                         cornerTopRightRadius: Double = 0,
                         cornerBottomLeftRadius: Double = 0,
                         cornerBottomRightRadius: Double = 0,
                         width: Double = 0) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.cornerRadiusMulti = cornerRadiusMulti
        self.cornerTopLeftRadius = cornerTopLeftRadius
        self.cornerTopRightRadius = cornerTopRightRadius
        self.cornerBottomLeftRadius = cornerBottomLeftRadius
        self.cornerBottomRightRadius = cornerBottomRightRadius
        self.width = width
    }
    
    // Codable protocol methods
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.color = try container.decode(DNSUIColor.self, forKey: .color)
        self.cornerRadius = try container.decode(Double.self, forKey: .cornerRadius)
        self.cornerRadiusMulti = try container.decode(Bool.self, forKey: .cornerRadiusMulti)
        self.cornerTopLeftRadius = try container.decode(Double.self, forKey: .cornerTopLeftRadius)
        self.cornerTopRightRadius = try container.decode(Double.self, forKey: .cornerTopRightRadius)
        self.cornerBottomLeftRadius = try container.decode(Double.self, forKey: .cornerBottomLeftRadius)
        self.cornerBottomRightRadius = try container.decode(Double.self, forKey: .cornerBottomRightRadius)
        self.width = try container.decode(Double.self, forKey: .width)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.color, forKey: .color)
        try container.encode(self.cornerRadius, forKey: .cornerRadius)
        try container.encode(self.cornerRadiusMulti, forKey: .cornerRadiusMulti)
        try container.encode(self.cornerTopLeftRadius, forKey: .cornerTopLeftRadius)
        try container.encode(self.cornerTopRightRadius, forKey: .cornerTopRightRadius)
        try container.encode(self.cornerBottomLeftRadius, forKey: .cornerBottomLeftRadius)
        try container.encode(self.cornerBottomRightRadius, forKey: .cornerBottomRightRadius)
        try container.encode(self.width, forKey: .width)
    }
    
    // Equatable protocol methods
    public static func == (lhs: DNSUIBorder, rhs: DNSUIBorder) -> Bool {
        guard lhs.color == rhs.color else { return false }
        guard lhs.cornerRadius == rhs.cornerRadius else { return false }
        guard lhs.cornerRadiusMulti == rhs.cornerRadiusMulti else { return false }
        guard lhs.cornerTopLeftRadius == rhs.cornerTopLeftRadius else { return false }
        guard lhs.cornerTopRightRadius == rhs.cornerTopRightRadius else { return false }
        guard lhs.cornerBottomLeftRadius == rhs.cornerBottomLeftRadius else { return false }
        guard lhs.cornerBottomRightRadius == rhs.cornerBottomRightRadius else { return false }
        guard lhs.width == rhs.width else { return false }
        return true
    }

    // Hashable protocol methods
    public func hash(into hasher: inout Hasher) {
        hasher.combine(color)
        hasher.combine(cornerRadius)
        hasher.combine(cornerRadiusMulti)
        hasher.combine(cornerTopLeftRadius)
        hasher.combine(cornerTopRightRadius)
        hasher.combine(cornerBottomLeftRadius)
        hasher.combine(cornerBottomRightRadius)
        hasher.combine(width)
    }

    // NSCopying protocol methods
    public func copy(with zone: NSZone? = nil) -> Any {
        let newColor = self.color
        let copy = DNSUIBorder(color: newColor, cornerRadius: cornerRadius, cornerRadiusMulti: cornerRadiusMulti,
                               cornerTopLeftRadius: cornerTopLeftRadius, cornerTopRightRadius: cornerTopRightRadius,
                               cornerBottomLeftRadius: cornerBottomLeftRadius,
                               cornerBottomRightRadius: cornerBottomRightRadius, width: width)
        return copy
    }
}

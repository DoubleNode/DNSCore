//
//  DNSUIBorder.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIBorder: Hashable {
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
}

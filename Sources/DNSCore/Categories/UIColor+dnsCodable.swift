//
//  UIColor+dnsCodable.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension UIColor {
    enum ColorSpace: String {
    case rgb, hsb, white
    }
    // Codable protocol methods
    static func decode(from container: KeyedDecodingContainer<ExtensionCodingKeys>) throws -> UIColor? {
        let alpha = try container.decode(Double.self, forKey: .alpha)
        let blue = try container.decode(Double.self, forKey: .blue)
        let brightness = try container.decode(Double.self, forKey: .brightness)
        let green = try container.decode(Double.self, forKey: .green)
        let hue = try container.decode(Double.self, forKey: .hue)
        let red = try container.decode(Double.self, forKey: .red)
        let saturation = try container.decode(Double.self, forKey: .saturation)
        let white = try container.decode(Double.self, forKey: .white)

        let colorSpaceRaw = try container.decode(String.self, forKey: .colorSpace)
        let colorSpace = ColorSpace(rawValue: colorSpaceRaw) ?? .white
        switch colorSpace {
        case .rgb: return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        case .hsb: return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        case .white: return UIColor(white: white, alpha: alpha)
        }
    }
    func encode(to container: KeyedEncodingContainer<ExtensionCodingKeys>) throws {
        var container = container
        var alpha: CGFloat = 0
        var blue: CGFloat = 0
        var brightness: CGFloat = 0
        var green: CGFloat = 0
        var hue: CGFloat = 0
        var red: CGFloat = 0
        var saturation: CGFloat = 0
        var white: CGFloat = 0
        var colorSpace: ColorSpace = .white
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            colorSpace = .rgb
        } else if self.getWhite(&white, alpha: &alpha) {
            colorSpace = .white
        } else if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            colorSpace = .hsb
        }
        try container.encode(alpha, forKey: .alpha)
        try container.encode(blue, forKey: .blue)
        try container.encode(brightness, forKey: .brightness)
        try container.encode(green, forKey: .green)
        try container.encode(hue, forKey: .hue)
        try container.encode(red, forKey: .red)
        try container.encode(saturation, forKey: .saturation)
        try container.encode(white, forKey: .white)
        try container.encode(colorSpace.rawValue, forKey: .colorSpace)
    }
}
#endif

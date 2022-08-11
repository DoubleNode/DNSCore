//
//  UIColor+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension UIColor {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    private static func xfield(_ from: ExtensionCodingKeys) -> String { return from.rawValue }
    enum ExtensionCodingKeys: String, CodingKey {
        case alpha, blue, brightness, green, hue, red, saturation, white
    }
    convenience init(from data: DNSDataDictionary) {
        let keys = data.keys
        if keys.contains("white") {
            // public init(white: CGFloat, alpha: CGFloat)
            let white = Self.xlt.double(from: data["white"] as Any?) ?? 0
            let alpha = Self.xlt.double(from: data["alpha"] as Any?) ?? 0
            self.init(white: white, alpha: alpha)
        } else if keys.contains("hue") {
            // public init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)
            let hue = Self.xlt.double(from: data["hue"] as Any?) ?? 0
            let saturation = Self.xlt.double(from: data["saturation"] as Any?) ?? 0
            let brightness = Self.xlt.double(from: data["brightness"] as Any?) ?? 0
            let alpha = Self.xlt.double(from: data["alpha"] as Any?) ?? 0
            self.init(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        } else if keys.contains("red") {
            // public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
            let red = Self.xlt.double(from: data["red"] as Any?) ?? 0
            let green = Self.xlt.double(from: data["green"] as Any?) ?? 0
            let blue = Self.xlt.double(from: data["blue"] as Any?) ?? 0
            let alpha = Self.xlt.double(from: data["alpha"] as Any?) ?? 0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
        self.init()
    }
    var asDictionary: DNSDataDictionary {
        var alpha: CGFloat = 0
        var blue: CGFloat = 0
        var brightness: CGFloat = 0
        var green: CGFloat = 0
        var hue: CGFloat = 0
        var red: CGFloat = 0
        var saturation: CGFloat = 0
        var white: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let retval: DNSDataDictionary = [
                Self.xfield(.red): Double(red),
                Self.xfield(.green): Double(green),
                Self.xfield(.blue): Double(blue),
                Self.xfield(.alpha): Double(alpha),
            ]
            return retval
        } else if self.getWhite(&white, alpha: &alpha) {
            let retval: DNSDataDictionary = [
                Self.xfield(.white): Double(white),
                Self.xfield(.alpha): Double(alpha),
            ]
            return retval
        } else if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let retval: DNSDataDictionary = [
                Self.xfield(.hue): Double(hue),
                Self.xfield(.saturation): Double(saturation),
                Self.xfield(.brightness): Double(brightness),
                Self.xfield(.alpha): Double(alpha),
            ]
            return retval
        }
        return .empty
    }
}
#endif

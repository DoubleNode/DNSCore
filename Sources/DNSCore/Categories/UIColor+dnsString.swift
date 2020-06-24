//
//  UIColor+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension UIColor {
    static private let dnsColorStrings = [
        "black": UIColor.black,
        "darkgray": UIColor.darkGray,
        "lightgray": UIColor.lightGray,
        "white": UIColor.white,
        "gray": UIColor.gray,
        "red": UIColor.red,
        "green": UIColor.green,
        "blue": UIColor.blue,
        "cyan": UIColor.cyan,
        "yellow": UIColor.yellow,
        "magenta": UIColor.magenta,
        "orange": UIColor.orange,
        "purple": UIColor.purple,
        "brown": UIColor.brown,
        "clear": UIColor.clear,
        "systemRed": UIColor.systemRed,
        "systemGreen": UIColor.systemGreen,
        "systemBlue": UIColor.systemBlue,
        "systemOrange": UIColor.systemOrange,
        "systemYellow": UIColor.systemYellow,
        "systemPink": UIColor.systemPink,
        "systemPurple": UIColor.systemPurple,
        "systemTeal": UIColor.systemTeal,
        "systemIndigo": UIColor.systemIndigo,
        "systemGray": UIColor.systemGray,
        "systemGray2": UIColor.systemGray2,
        "systemGray3": UIColor.systemGray3,
        "systemGray4": UIColor.systemGray4,
        "systemGray5": UIColor.systemGray5,
        "systemGray6": UIColor.systemGray6,
        "label": UIColor.label,
        "secondaryLabel": UIColor.secondaryLabel,
        "tertiaryLabel": UIColor.tertiaryLabel,
        "quaternaryLabel": UIColor.quaternaryLabel,
        "link": UIColor.link,
        "placeholderText": UIColor.placeholderText,
        "separator": UIColor.separator,
        "opaqueSeparator": UIColor.opaqueSeparator,
        "systemBackground": UIColor.systemBackground,
        "secondarySystemBackground": UIColor.secondarySystemBackground,
        "tertiarySystemBackground": UIColor.tertiarySystemBackground,
        "systemGroupedBackground": UIColor.systemGroupedBackground,
        "secondarySystemGroupedBackground": UIColor.secondarySystemGroupedBackground,
        "tertiarySystemGroupedBackground": UIColor.tertiarySystemGroupedBackground,
        "systemFill": UIColor.systemFill,
        "secondarySystemFill": UIColor.secondarySystemFill,
        "tertiarySystemFill": UIColor.tertiarySystemFill,
        "quaternarySystemFill": UIColor.quaternarySystemFill,
        "lightText": UIColor.lightText,
        "darkText": UIColor.darkText,
    ]

    convenience init(with string: String) {
        let match = UIColor.dnsColorStrings.first(where: { string == $0.key })?.value
        if match != nil {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            match!.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

            self.init(red: red,
                      green: green,
                      blue: blue,
                      alpha: alpha)
            return
        }

        let hexString = string.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hexString).scanHexInt64(&int)

        let aValue, rValue, gValue, bValue: UInt32

        switch hexString.count {
        case 3: // RGB (12-bit)
            (aValue, rValue, gValue, bValue) = (255,
                                                UInt32((int >> 8) * 17),
                                                UInt32((int >> 4 & 0xF) * 17),
                                                UInt32((int & 0xF) * 17))
        case 6: // RGB (24-bit)
            (aValue, rValue, gValue, bValue) = (255,
                                                UInt32(int >> 16),
                                                UInt32(int >> 8 & 0xFF),
                                                UInt32(int & 0xFF))
        case 8: // ARGB (32-bit)
            (aValue, rValue, gValue, bValue) = (UInt32(int >> 24),
                                                UInt32(int >> 16 & 0xFF),
                                                UInt32(int >> 8 & 0xFF),
                                                UInt32(int & 0xFF))
        default:
            (aValue, rValue, gValue, bValue) = (255, 0, 0, 0)
        }

        self.init(red: CGFloat(rValue) / 255,
                  green: CGFloat(gValue) / 255,
                  blue: CGFloat(bValue) / 255,
                  alpha: CGFloat(aValue) / 255)
    }
}

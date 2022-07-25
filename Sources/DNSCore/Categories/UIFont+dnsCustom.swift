//
//  UIFont+dnsCustom.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension UIFont {
    class func dnsCustom(with name: String, and size: CGFloat) -> UIFont {
        return UIFont(descriptor: UIFontDescriptor(name: name, size: size), size: size)
    }

    class func dnsDumpFonts() {
        NSLog("Available Fonts")
        for familyName in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                NSLog("%@: %@", familyName, fontName)
            }
        }
    }
}
#endif

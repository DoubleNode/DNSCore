//
//  UIFont+dnsCustom.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/22/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

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

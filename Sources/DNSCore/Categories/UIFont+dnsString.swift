//
//  UIFont+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension UIFont {
    convenience init(with string: String) {
        var name = string.isEmpty ? "System" : string
        var size = Double(12)
        if string.contains(",") {
            let strings = string.components(separatedBy: ",")
            if strings.count > 1 {
                name = Self.xlt.string(from: strings[0]) ?? "System"
                size = Self.xlt.double(from: strings[1]) ?? 12
            }
        }
        self.init(descriptor: UIFontDescriptor(name: name, size: size), size: size)
    }
}
#endif

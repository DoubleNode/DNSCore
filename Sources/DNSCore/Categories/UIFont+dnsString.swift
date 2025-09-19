//
//  UIFont+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIFont {
    convenience init?(with string: String) {
        var name: String?
        var size: Double?
        if string.contains(",") {
            let strings = string.components(separatedBy: ",")
            if strings.count > 1 {
                name = Self.xlt.string(from: strings[0])
                size = Self.xlt.double(from: strings[1])
            }
        }
        guard let name, let size else { return nil }
        self.init(descriptor: UIFontDescriptor(name: name, size: size), size: size)
    }
}
#endif

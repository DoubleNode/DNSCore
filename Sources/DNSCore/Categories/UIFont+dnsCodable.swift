//
//  UIFont+dnsCodable.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension UIFont {
    // Codable protocol methods
    static func decode(from container: KeyedDecodingContainer<ExtensionCodingKeys>) throws -> UIFont? {
        let name = try container.decode(String.self, forKey: .name)
        let size = try container.decode(Double.self, forKey: .size)
        return UIFont(name: name, size: size)
    }
    func encode(to container: KeyedEncodingContainer<ExtensionCodingKeys>) throws {
        var container = container
        try container.encode(self.fontName, forKey: .name)
        try container.encode(self.pointSize, forKey: .size)
    }
}
#endif

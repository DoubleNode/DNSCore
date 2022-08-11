//
//  UIFont+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension UIFont {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    private static func xfield(_ from: ExtensionCodingKeys) -> String { return from.rawValue }
    enum ExtensionCodingKeys: String, CodingKey {
        case name, size
    }
    convenience init(from data: DNSDataDictionary) {
        let name = Self.xlt.string(from: data[Self.xfield(.name)] as Any?) ?? "System"
        let size = Self.xlt.double(from: data[Self.xfield(.size)] as Any?) ?? 12
        self.init(descriptor: UIFontDescriptor(name: name, size: size), size: size)
    }
    var asDictionary: DNSDataDictionary {
        let retval: DNSDataDictionary = [
            Self.xfield(.name): String(self.fontName),
            Self.xfield(.size): Double(self.pointSize),
        ]
        return retval
    }
}
#endif

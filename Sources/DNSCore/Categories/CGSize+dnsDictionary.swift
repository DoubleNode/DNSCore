//
//  CGSize+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension CGSize {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    private static func xfield(_ from: ExtensionCodingKeys) -> String { return from.rawValue }
    enum ExtensionCodingKeys: String, CodingKey {
        case width, height
    }
    init(from data: DNSDataDictionary) {
        let width = Self.xlt.double(from: data[Self.xfield(.width)] as Any?) ?? 0
        let height = Self.xlt.double(from: data[Self.xfield(.height)] as Any?) ?? 0
        self.init(width: width, height: height)
    }
    var asDictionary: DNSDataDictionary {
        let retval: DNSDataDictionary = [
            Self.xfield(.width): Double(self.width),
            Self.xfield(.height): Double(self.height),
        ]
        return retval
    }
}
#endif

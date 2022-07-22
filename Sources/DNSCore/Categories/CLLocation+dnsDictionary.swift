//
//  CLLocation+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import CoreLocation
import Foundation

public extension CLLocation {
    static let translation = DNSDataTranslation()
    // MARK: - Properties -
    private static func xfield(_ from: ExtensionCodingKeys) -> String { return from.rawValue }
    enum ExtensionCodingKeys: String, CodingKey {
        case latitude, longitude
    }
    convenience init(with data: DNSDataDictionary) {
        let latitude = Self.translation.double(from: data[Self.xfield(.latitude)] as Any?) ?? 0.0
        let longitude = Self.translation.double(from: data[Self.xfield(.longitude)] as Any?) ?? 0.0
        self.init(latitude: latitude, longitude: longitude)
    }
    var asDictionary: DNSDataDictionary {
        let retval = [
            Self.xfield(.latitude): self.coordinate.latitude,
            Self.xfield(.longitude): self.coordinate.longitude,
        ]
        return retval
    }
}

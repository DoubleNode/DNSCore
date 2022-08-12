//
//  DNSDataTranslation+CLLocation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import CoreLocation
import DNSCoreThreading
import Foundation

public extension DNSDataTranslation {
    // MARK: - location...
    // swiftlint:disable:next cyclomatic_complexity
    func location(from any: Any?) -> CLLocation? {
        guard let any else { return nil }
        if any is CLLocation {
            return self.location(from: any as? CLLocation)
        } else if any is DNSDataDictionary {
            return self.location(from: any as? DNSDataDictionary)
        }
        return self.location(from: any as? String)
    }
    func location(from location: CLLocation?) -> CLLocation? {
        guard let location else { return nil }
        return location
    }
    func location(from dictionary: DNSDataDictionary?) -> CLLocation? {
        guard let dictionary else { return nil }
        return CLLocation(from: dictionary)
    }
    func location(from string: String?) -> CLLocation? {
        guard let string else { return nil }
        return CLLocation(with: string)
    }
}

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
        guard let any = any else { return nil }
        return self.location(from: any as? [String: Double])
    }
    func location(from dictionary: [String: Double]?) -> CLLocation? {
        guard let dictionary = dictionary else { return nil }
        return CLLocation(from: dictionary)
    }
}

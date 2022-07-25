//
//  DNSDataTranslation+DNSDataArray.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation

public extension DNSDataTranslation {
    // MARK: - dataarray...
    // swiftlint:disable:next cyclomatic_complexity
    func dataarray(from any: Any?) -> DNSDataArray? {
        guard any != nil else { return nil }
        return self.dataarray(from: any as? DNSDataArray)
    }
    func dataarray(from dataarray: DNSDataArray?) -> DNSDataArray? {
        guard let dataarray else { return nil }
        return dataarray
    }
}

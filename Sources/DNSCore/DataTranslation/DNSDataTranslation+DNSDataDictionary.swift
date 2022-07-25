//
//  DNSDataTranslation+DNSDataDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation

public extension DNSDataTranslation {
    // MARK: - datadictionary...
    // swiftlint:disable:next cyclomatic_complexity
    func datadictionary(from any: Any?) -> DNSDataDictionary? {
        guard any != nil else { return nil }
        return self.datadictionary(from: any as? DNSDataDictionary)
    }
    func datadictionary(from datadictionary: DNSDataDictionary?) -> DNSDataDictionary? {
        guard let datadictionary else { return nil }
        return datadictionary
    }
}

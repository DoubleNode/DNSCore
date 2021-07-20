//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - float...
    // swiftlint:disable:next cyclomatic_complexity
    func float(from any: Any?) -> Float? {
        guard any != nil else { return nil }
        if any is Date {
            return self.float(from: any as? Date)
        } else if any is UIColor {
            return self.float(from: any as? UIColor)
        } else if any is URL {
            return self.float(from: any as? URL)
        } else if any is NSNumber {
            return self.float(from: any as? NSNumber)
        } else if any is Decimal {
            return self.float(from: any as? Decimal)
        } else if any is Double {
            return self.float(from: any as? Double)
        } else if any is Float {
            return self.float(from: any as? Float)
        } else if any is UInt {
            return self.float(from: any as? UInt)
        } else if any is Int {
            return self.float(from: any as? Int)
        } else if any is Bool {
            return self.float(from: any as? Bool)
        }
        return self.float(from: any as? String, nil)
    }
    func float(from float: Float?) -> Float? {
        guard float != nil else { return 0 }
        return float
    }
    func float(from number: NSNumber?) -> Float? {
        guard number != nil else { return 0 }
        return number?.floatValue
    }
    func float(from string: String?, _ numberFormatter: NumberFormatter?) -> Float? {
        guard !(string?.isEmpty ?? true) else { return nil }
        return self.number(from: string, numberFormatter)?.floatValue
    }
}

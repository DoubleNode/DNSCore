//
//  DNSDataTranslation+Int.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - int...
    // swiftlint:disable:next cyclomatic_complexity
    func int(from any: Any?) -> Int? {
        guard any != nil else { return nil }
        if any is Date {
            return self.int(from: any as? Date)
        } else if any is UIColor {
            return self.int(from: any as? UIColor)
        } else if any is URL {
            return self.int(from: any as? URL)
        } else if any is NSNumber {
            return self.int(from: any as? NSNumber)
        } else if any is Decimal {
            return self.int(from: any as? Decimal)
        } else if any is Double {
            return self.int(from: any as? Double)
        } else if any is Float {
            return self.int(from: any as? Float)
        } else if any is UInt {
            return self.int(from: any as? UInt)
        } else if any is Int {
            return self.int(from: any as? Int)
        } else if any is Bool {
            return self.int(from: any as? Bool)
        }
        return self.int(from: any as? String, nil)
    }
    func int(from int: Int?) -> Int? {
        guard int != nil else { return 0 }
        return int
    }
    func int(from number: NSNumber?) -> Int? {
        guard number != nil else { return 0 }
        return number?.intValue
    }
    func int(from string: String?, _ numberFormatter: NumberFormatter?) -> Int? {
        guard !(string?.isEmpty ?? true) else { return nil }
        return self.number(from: string, numberFormatter)?.intValue
    }
}

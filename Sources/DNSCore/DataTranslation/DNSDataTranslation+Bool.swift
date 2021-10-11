//
//  DNSDataTranslation+Bool.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - bool...
    // swiftlint:disable:next cyclomatic_complexity
    func bool(from any: Any?) -> Bool? {
        guard any != nil else { return nil }
        if any is Date {
            return self.bool(from: any as? Date)
        } else if any is UIColor {
            return self.bool(from: any as? UIColor)
        } else if any is URL {
            return self.bool(from: any as? URL)
        } else if any is NSNumber {
            return self.bool(from: any as? NSNumber)
        } else if any is Decimal {
            return self.bool(from: any as? Decimal)
        } else if any is Double {
            return self.bool(from: any as? Double)
        } else if any is Float {
            return self.bool(from: any as? Float)
        } else if any is UInt {
            return self.bool(from: any as? UInt)
        } else if any is Int {
            return self.bool(from: any as? Int)
        } else if any is Bool {
            return self.bool(from: any as? Bool)
        }
        return self.bool(from: any as? String)
    }
    func bool(from bool: Bool?) -> Bool? {
        guard bool != nil else { return nil }
        return bool
    }
    func bool(from number: NSNumber?) -> Bool? {
        guard number != nil else { return nil }
        return bool(from: "\(number!)")
    }
    func bool(from string: String?) -> Bool? {
        guard !(string?.isEmpty ?? true) else { return nil }
        return boolTrueCharacters.contains(string![string!.startIndex])
    }
}

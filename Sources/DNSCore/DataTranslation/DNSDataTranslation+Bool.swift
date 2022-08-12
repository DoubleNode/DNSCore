//
//  DNSDataTranslation+Bool.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation
#if !os(macOS)
import UIKit
#endif

public extension DNSDataTranslation {
    // MARK: - bool...
    // swiftlint:disable:next cyclomatic_complexity
    func bool(from any: Any?) -> Bool? {
        guard let any else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.bool(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.bool(from: any as? Date)
        } else
        if any is URL {
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
        guard let bool else { return nil }
        return bool
    }
    func bool(from number: NSNumber?) -> Bool? {
        guard let number else { return nil }
        return bool(from: "\(number)")
    }
    func bool(from string: String?) -> Bool? {
        guard let string else { return nil }
        guard !string.isEmpty else { return nil }
        return boolTrueCharacters.contains(string[string.startIndex])
    }
}

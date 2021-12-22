//
//  DNSDataTranslation+UInt.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation
#if !os(macOS)
import UIKit
#endif

public extension DNSDataTranslation {
    // MARK: - uint...
    // swiftlint:disable:next cyclomatic_complexity
    func uint(from any: Any?) -> UInt? {
        guard any != nil else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.uint(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.uint(from: any as? Date)
        } else if any is URL {
            return self.uint(from: any as? URL)
        } else if any is UInt {
            return self.uint(from: any as? UInt)
        } else if any is Int {
            return self.uint(from: any as? Int)
        } else if any is NSNumber {
            return self.uint(from: any as? NSNumber)
        } else if any is Decimal {
            return self.uint(from: any as? Decimal)
        } else if any is Double {
            return self.uint(from: any as? Double)
        } else if any is Float {
            return self.uint(from: any as? Float)
        } else if any is Bool {
            return self.uint(from: any as? Bool)
        }
        return self.uint(from: any as? String, nil)
    }
    func uint(from int: Int?) -> UInt? {
        guard int != nil else { return 0 }
        return UInt(abs(Int32(int!)))
    }
    func uint(from uint: UInt?) -> UInt? {
        guard uint != nil else { return 0 }
        return uint
    }
    func uint(from number: NSNumber?) -> UInt? {
        guard number != nil else { return 0 }
        return number?.uintValue
    }
    func uint(from string: String?, _ numberFormatter: NumberFormatter?) -> UInt? {
        guard !(string?.isEmpty ?? true) else { return 0 }
        return self.number(from: string, numberFormatter)?.uintValue
    }
}

//
//  DNSDataTranslation+Decimal.swift
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
    // MARK: - decimal...
    // swiftlint:disable:next cyclomatic_complexity
    func decimal(from any: Any?) -> Decimal? {
        guard any != nil else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.decimal(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.decimal(from: any as? Date)
        } else if any is URL {
            return self.decimal(from: any as? URL)
        } else if any is NSNumber {
            return self.decimal(from: any as? NSNumber)
        } else if any is Decimal {
            return self.decimal(from: any as? Decimal)
        } else if any is Double {
            return self.decimal(from: any as? Double)
        } else if any is Float {
            return self.decimal(from: any as? Float)
        } else if any is UInt {
            return self.decimal(from: any as? UInt)
        } else if any is Int {
            return self.decimal(from: any as? Int)
        } else if any is Bool {
            return self.decimal(from: any as? Bool)
        }
        return self.decimal(from: any as? String, nil)
    }
    func decimal(from decimal: Decimal?) -> Decimal? {
        guard let decimal else { return Decimal(0) }
        return decimal
    }
    func decimal(from number: NSNumber?) -> Decimal? {
        guard let number else { return Decimal(0) }
        return number.decimalValue
    }
    func decimal(from string: String?, _ decimalFormatter: NumberFormatter?) -> Decimal? {
        guard let string else { return Decimal(0) }
        guard !string.isEmpty else { return Decimal(0) }
        let formatter = decimalFormatter ?? DNSDataTranslation.defaultNumberFormatter
        return decimal(from: formatter.number(from: string))
    }
}

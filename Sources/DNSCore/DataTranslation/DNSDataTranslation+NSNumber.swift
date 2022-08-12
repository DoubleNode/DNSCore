//
//  DNSDataTranslation+NSNumber.swift
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
    // MARK: - number...
    // swiftlint:disable:next cyclomatic_complexity
    func number(from any: Any?) -> NSNumber? {
        guard let any else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.number(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.number(from: any as? Date)
        } else
        if any is URL {
            return self.number(from: any as? URL)
        } else if any is NSNumber {
            return self.number(from: any as? NSNumber)
        } else if any is Decimal {
            return self.number(from: any as? Decimal)
        } else if any is Double {
            return self.number(from: any as? Double)
        } else if any is Float {
            return self.number(from: any as? Float)
        } else if any is UInt {
            return self.number(from: any as? UInt)
        } else if any is Int {
            return self.number(from: any as? Int)
        } else if any is Bool {
            return self.number(from: any as? Bool)
        }
        return self.number(from: any as? String)
    }
    func number(from number: NSNumber?) -> NSNumber? {
        guard let number else { return nil }
        return number
    }
    func number(from string: String?, _ numberFormatter: NumberFormatter? = nil) -> NSNumber? {
        guard let string else { return nil }
        guard !string.isEmpty else { return nil }
        let formatter = numberFormatter ?? DNSDataTranslation.defaultNumberFormatter
        return formatter.number(from: string)
    }
}

//
//  DNSDataTranslation+ID.swift
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
    // MARK: - id...
    // swiftlint:disable:next cyclomatic_complexity
    func id(from any: Any?) -> String? {
        guard any != nil else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.string(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.string(from: any as? Date)
        } else if any is URL {
            return self.string(from: any as? URL)
        } else if any is NSNumber {
            return self.string(from: any as? NSNumber)
        } else if any is Decimal {
            return self.string(from: any as? Decimal)
        } else if any is Double {
            return self.string(from: any as? Double)
        } else if any is Float {
            return self.string(from: any as? Float)
        } else if any is UInt {
            return self.string(from: any as? UInt)
        } else if any is Int {
            return self.string(from: any as? Int)
        } else if any is Bool {
            return self.string(from: any as? Bool)
        }

        return self.id(from: any as? String)
    }
    func id(from string: String?) -> String? {
        guard var string else { return nil }
        guard !string.isEmpty else { return nil }
        string = string.replacingOccurrences(of: "/", with: "")
        return string
    }
}

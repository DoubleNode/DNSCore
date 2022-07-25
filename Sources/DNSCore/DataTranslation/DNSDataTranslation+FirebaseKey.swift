//
//  DNSDataTranslation+FirebaseKey.swift
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
    // MARK: - firebaseKeyFrom...
    // swiftlint:disable:next cyclomatic_complexity
    func firebaseKey(from any: Any?) -> String? {
        guard any != nil else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.firebaseKey(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.firebaseKey(from: any as? Date)
        } else if any is URL {
            return self.firebaseKey(from: any as? URL)
        } else if any is NSNumber {
            return self.firebaseKey(from: any as? NSNumber)
        } else if any is Decimal {
            return self.firebaseKey(from: any as? Decimal)
        } else if any is Double {
            return self.firebaseKey(from: any as? Double)
        } else if any is Float {
            return self.firebaseKey(from: any as? Float)
        } else if any is UInt {
            return self.firebaseKey(from: any as? UInt)
        } else if any is Int {
            return self.firebaseKey(from: any as? Int)
        } else if any is Bool {
            return self.firebaseKey(from: any as? Bool)
        }
        return self.firebaseKey(from: any as? String)
    }
    func firebaseKey(from string: String?) -> String? {
        guard let string = string else { return nil }
        guard !string.isEmpty else { return nil }
        return string.components(separatedBy: firebaseKeyInvalidCharacterSet)
            .joined(separator: "_")
    }
}

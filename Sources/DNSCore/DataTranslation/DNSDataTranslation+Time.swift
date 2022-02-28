//
//  DNSDataTranslation+Time.swift
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
    // MARK: - time...
    // swiftlint:disable:next cyclomatic_complexity
    func time(from any: Any?) -> Date? {
        guard any != nil else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.time(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.time(from: any as? Date)
        } else if any is URL {
            return self.time(from: any as? URL)
        } else if any is NSNumber {
            return self.time(from: any as? NSNumber)
        } else if any is Decimal {
            return self.time(from: any as? Decimal)
        } else if any is Double {
            return self.time(from: any as? Double)
        } else if any is Float {
            return self.time(from: any as? Float)
        } else if any is UInt {
            return self.time(from: any as? UInt)
        } else if any is Int {
            return self.time(from: any as? Int)
        } else if any is Bool {
            return self.time(from: any as? Bool)
        }
        return self.time(from: any as? String)
    }
    func time(from dictionary: [String: String]?) -> Date? {
        guard dictionary != nil else { return nil }
        let string = dictionary![firebaseDateDictionaryISOKey] ?? ""
        return self.time(from: string, DNSDataTranslation.firebaseTimeFormatterMilliseconds)
    }
    func time(from number: NSNumber?) -> Date? {
        guard let number = self.number(from: number) else { return nil }
        return self.date(fromTimeIntervalSince1970: number)
    }
    func time(from string: String?, _ timeFormatter: DateFormatter? = nil) -> Date? {
        guard string != nil else { return nil }
        guard let timeFormatter = timeFormatter else {
            for formatter in DNSDataTranslation.defaultTimeFormatters {
                if let retval = self.date(from: string, formatter) {
                    return retval
                }
            }
            if let number = self.number(from: string) {
                return self.date(fromTimeIntervalSince1970: number)
            }
            return nil
        }
        return timeFormatter.date(from: string!)
    }
    func time(from time: Date?) -> Date? {
        guard time != nil else { return nil }
        return time
    }
}

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
    // MARK: - date...
    // swiftlint:disable:next cyclomatic_complexity
    func date(from any: Any?) -> Date? {
        guard any != nil else { return nil }
        if any is Date {
            return self.date(from: any as? Date)
        } else if any is UIColor {
            return self.date(from: any as? UIColor)
        } else if any is URL {
            return self.date(from: any as? URL)
        } else if any is NSNumber {
            return self.date(from: any as? NSNumber)
        } else if any is Decimal {
            return self.date(from: any as? Decimal)
        } else if any is Double {
            return self.date(from: any as? Double)
        } else if any is Float {
            return self.date(from: any as? Float)
        } else if any is UInt {
            return self.date(from: any as? UInt)
        } else if any is Int {
            return self.date(from: any as? Int)
        } else if any is Bool {
            return self.date(from: any as? Bool)
        }
        return self.date(from: any as? String, nil)
    }
    func date(from date: Date?) -> Date? {
        guard date != nil else { return nil }
        return date
    }
    func date(from dictionary: [String: String]?) -> Date? {
        guard dictionary != nil else { return nil }
        let string = dictionary![firebaseDateDictionaryISOKey] ?? ""
        return self.date(from: string, DNSDataTranslation.firebaseDateFormatter)
    }
    func date(from number: NSNumber?) -> Date? {
        guard number != nil else { return nil }
        return Date.init(timeIntervalSinceReferenceDate: number!.doubleValue)
    }
    func date(fromTimeIntervalSince1970 number: NSNumber?) -> Date? {
        guard number != nil else { return nil }
        return Date.init(timeIntervalSince1970: number!.doubleValue)
    }
    func date(from string: String?, _ dateFormatter: DateFormatter?) -> Date? {
        guard !(string?.isEmpty ?? true) else { return nil }
        guard dateFormatter != nil else {
            for formatter in DNSDataTranslation.defaultDateFormatters {
                let retval = self.date(from: string, formatter)
                guard retval == nil else {  return retval   }
            }
            return nil
        }
        return dateFormatter!.date(from: string!)
    }
}

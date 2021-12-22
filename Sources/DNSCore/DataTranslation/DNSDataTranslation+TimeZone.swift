//
//  DNSDataTranslation+TimeZone.swift
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
    // MARK: - timeOfDay...
    // swiftlint:disable:next cyclomatic_complexity
    func timeZone(from any: Any?) -> TimeZone? {
        guard any != nil else { return nil }
        if any is TimeZone {
            return self.timeZone(from: any as? TimeZone)
        } else if any is NSNumber {
            return self.timeZone(from: any as? NSNumber)
        } else if any is Decimal {
            return self.timeZone(from: any as? Decimal)
        } else if any is Double {
            return self.timeZone(from: any as? Double)
        } else if any is Float {
            return self.timeZone(from: any as? Float)
        } else if any is Int {
            return self.timeZone(from: any as? Int)
        }
        return self.timeZone(from: any as? String)
    }
    func timeZone(from value: TimeZone?) -> TimeZone? {
        guard value != nil else { return TimeZone.current }
        return value
    }
    func timeZone(from value: NSNumber?) -> TimeZone? {
        guard let value = value else { return TimeZone.current }
        return TimeZone(secondsFromGMT: Int(value.doubleValue * Date.Seconds.deltaOneHour))
    }
    func timeZone(from value: Decimal?) -> TimeZone? {
        guard let value = value as NSDecimalNumber? else { return TimeZone.current }
        return TimeZone(secondsFromGMT: Int(value.doubleValue * Date.Seconds.deltaOneHour))
    }
    func timeZone(from value: Double?) -> TimeZone? {
        guard let value = value else { return TimeZone.current }
        return TimeZone(secondsFromGMT: Int(value * Date.Seconds.deltaOneHour))
    }
    func timeZone(from value: Float?) -> TimeZone? {
        guard let value = value else { return TimeZone.current }
        return TimeZone(secondsFromGMT: Int(Double(value) * Date.Seconds.deltaOneHour))
    }
    func timeZone(from value: Int?) -> TimeZone? {
        guard let value = value else { return TimeZone.current }
        return TimeZone(secondsFromGMT: Int(Double(value) * Date.Seconds.deltaOneHour))
    }
    func timeZone(from value: String?) -> TimeZone? {
        guard let value = value else { return TimeZone.current }
        guard !value.isEmpty else { return nil }
        return TimeZone(identifier: value)
    }
}

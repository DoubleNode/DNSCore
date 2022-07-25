//
//  DNSDataTranslation+TimeZone.swift
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
    func timeZone(from timezone: TimeZone?) -> TimeZone? {
        guard let timezone = timezone else { return TimeZone.current }
        return timezone
    }
    func timeZone(from number: NSNumber?) -> TimeZone? {
        guard let number = number else { return TimeZone.current }
        return TimeZone(secondsFromGMT: Int(number.doubleValue * Date.Seconds.deltaOneHour))
    }
    func timeZone(from decimal: Decimal?) -> TimeZone? {
        guard let decimal = decimal as NSDecimalNumber? else { return TimeZone.current }
        return TimeZone(secondsFromGMT: Int(decimal.doubleValue * Date.Seconds.deltaOneHour))
    }
    func timeZone(from double: Double?) -> TimeZone? {
        guard let double = double else { return TimeZone.current }
        return TimeZone(secondsFromGMT: Int(double * Date.Seconds.deltaOneHour))
    }
    func timeZone(from float: Float?) -> TimeZone? {
        guard let float = float else { return TimeZone.current }
        return TimeZone(secondsFromGMT: Int(Double(float) * Date.Seconds.deltaOneHour))
    }
    func timeZone(from int: Int?) -> TimeZone? {
        guard let int = int else { return TimeZone.current }
        return TimeZone(secondsFromGMT: Int(Double(int) * Date.Seconds.deltaOneHour))
    }
    func timeZone(from string: String?) -> TimeZone? {
        guard let string = string else { return TimeZone.current }
        guard !string.isEmpty else { return TimeZone.current }
        return TimeZone(identifier: string)
    }
}

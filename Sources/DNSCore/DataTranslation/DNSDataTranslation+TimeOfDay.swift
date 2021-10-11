//
//  DNSDataTranslation+TimeOfDay.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - timeOfDay...
    // swiftlint:disable:next cyclomatic_complexity
    func timeOfDay(from any: Any?) -> DNSTimeOfDay? {
        guard any != nil else { return nil }
        if any is Date {
            return self.timeOfDay(from: any as? Date)
        } else if any is UIColor {
            return self.timeOfDay(from: any as? UIColor)
        } else if any is DNSTimeOfDay {
            return self.timeOfDay(from: any as? DNSTimeOfDay)
        } else if any is URL {
            return self.timeOfDay(from: any as? URL)
        } else if any is NSNumber {
            return self.timeOfDay(from: any as? NSNumber)
        } else if any is Decimal {
            return self.timeOfDay(from: any as? Decimal)
        } else if any is Double {
            return self.timeOfDay(from: any as? Double)
        } else if any is Float {
            return self.timeOfDay(from: any as? Float)
        } else if any is UInt {
            return self.timeOfDay(from: any as? UInt)
        } else if any is Int {
            return self.timeOfDay(from: any as? Int)
        } else if any is Bool {
            return self.timeOfDay(from: any as? Bool)
        }
        return self.timeOfDay(from: any as? String)
    }
    func timeOfDay(from timeOfDay: DNSTimeOfDay?) -> DNSTimeOfDay? {
        guard timeOfDay != nil else { return DNSTimeOfDay() }
        return timeOfDay
    }
    func timeOfDay(from number: NSNumber?) -> DNSTimeOfDay? {
        guard number != nil else { return DNSTimeOfDay() }
        return DNSTimeOfDay(timeValue: number?.floatValue ?? 0)
    }
    func timeOfDay(from string: String?) -> DNSTimeOfDay? {
        guard !(string?.isEmpty ?? true) else { return nil }
        let strings = string?.components(separatedBy: [":", " "]) ?? []
        var hourValue = Float(0.0)
        var minuteValue = Float(0.0)
        if !strings.isEmpty {
            hourValue = self.number(from: strings[0],
                                    DNSDataTranslation.defaultNumberFormatter)?.floatValue ?? 0
            if hourValue == 12 {
                hourValue = 0
            }
        }
        if strings.count > 1 {
            minuteValue = self.number(from: strings[1],
                                      DNSDataTranslation.defaultNumberFormatter)?.floatValue ?? 0
        }
        if strings.count > 2 {
            if strings[2].uppercased() == "PM" {
                hourValue += 12
            }
        }
        let timeValue = hourValue + (minuteValue / 60)
        return DNSTimeOfDay(timeValue: timeValue)
    }
}

//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - timeOfDay...
    // swiftlint:disable:next cyclomatic_complexity
    func timeOfDay(from any: Any?) -> Date? {
        guard timeOfDayEntryCount == 0 else {
            assertionFailure("DNSDataTranslation.timeOfDay(from any) reentered!")
            return nil
        }
        timeOfDayEntryCount += 1
        defer { timeOfDayEntryCount -= 1 }

        guard any != nil else { return nil }

        if any as? Date != nil {
            return self.timeOfDay(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.timeOfDay(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.timeOfDay(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.timeOfDay(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.timeOfDay(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.timeOfDay(from: any as? Double)
        } else if any as? Float != nil {
            return self.timeOfDay(from: any as? Float)
        } else if any as? UInt != nil {
            return self.timeOfDay(from: any as? UInt)
        } else if any as? Int != nil {
            return self.timeOfDay(from: any as? Int)
        } else if any as? Bool != nil {
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

//
//  DNSTimeOfDay.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public class DNSTimeOfDay: Hashable {
    public enum Period {
        case morning
        case afternoon
        case evening
    }
    public var period: Period {
        switch hour {
        case ..<12:
            return .morning
        case 12..<17:
            return .afternoon
        default:
            return .evening
        }
    }

    public var value: Float = 0

    public var hour: Int {
        return Int(value)
    }
    public var minute: Int {
        return Int((value - Float(Int(value))) * 60)
    }
    
    public var totalSeconds: Int {
        return hour * Int(Date.Seconds.deltaOneHour) + minute * Int(Date.Seconds.deltaOneMinute)
    }

    public required init(timeValue: Float = 0) {
        value = timeValue
    }

    public func asMilitary() -> String {
        return String(format: "%02d%02d", self.hour % 24, self.minute)
    }
    public func timeAsString(forceMinutes: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "HH:mm",
                                                            options: 0,
                                                            locale: Locale.current)
        let date = dateFormatter.date(from: "\(String(format: "%02d", self.hour % 24)):\(String(format: "%02d", self.minute))")
        guard date != nil else {
            return ""
        }

        var timeFormatString = "ha"
        if forceMinutes || (self.minute > 0) {
            timeFormatString = "h:mma"
        }
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: timeFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: date!)
        retval = Date.utilityMinimizeAmPm(of: retval)
        return retval
    }

    // MARK: - Comparable methods

    public static func <(lhs: DNSTimeOfDay, rhs: DNSTimeOfDay) -> Bool {
        return lhs.value < rhs.value
    }

    // MARK: - Hashable methods

    public static func ==(lhs: DNSTimeOfDay, rhs: DNSTimeOfDay) -> Bool {
        return lhs.value == rhs.value
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

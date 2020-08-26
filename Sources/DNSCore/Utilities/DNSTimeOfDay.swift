//
//  DNSTimeOfDay.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public class DNSTimeOfDay: Hashable {
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

    public func timeAsString(forceMinutes: Bool = false) -> String {
        let hour = self.hour % 12
        let amPm = (self.hour % 24) < 12 ? "a" : "p"

        var minStr = ""
        if forceMinutes || (self.minute > 0) {
            minStr = String(format: ":%02d", self.minute)
        }

        return "\((hour != 0) ? hour : 12)\(minStr)\(amPm)"
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

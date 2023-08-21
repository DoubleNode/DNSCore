//
//  DNSDuration.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public class DNSDuration: Hashable, Comparable, Codable {
    public var value: Float = 0

    public var hour: Int {
        return Int(value)
    }
    public var minute: Int {
        return Int((value - Float(hour)) * 60)
    }
    public var totalSeconds: Int {
        return hour * Int(Date.Seconds.deltaOneHour) + minute * Int(Date.Seconds.deltaOneMinute)
    }
    
    public required init(timeValue: Float = 0) {
        value = timeValue
    }
    public required init(hour: Int,
                         minute: Int) {
        value = Float(hour) + ((Float(minute) + 0.5) / 60)
    }

    public func asMilitary(with colon: Bool = false) -> String {
        return String(format: "%02d%@%02d", self.hour % 24, (colon ? ":" : ""), self.minute)
    }
    public func asString(forceMinutes: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: "\(String(format: "%02d", self.hour % 24)):\(String(format: "%02d", self.minute))")
        guard date != nil else {
            return ""
        }

        var timeFormatString = "h"
        if forceMinutes || (self.minute > 0) {
            timeFormatString = "h:mm"
        }
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: date!)
        return retval
    }

    // MARK: - Comparable methods
    public static func <(lhs: DNSDuration, rhs: DNSDuration) -> Bool {
        return lhs.value < rhs.value
    }

    // MARK: - Hashable methods
    static public func ==(lhs: DNSDuration, rhs: DNSDuration) -> Bool {
        return lhs.value == rhs.value
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }

    // MARK: - Operator methods
    static func - (lhs: DNSDuration, rhs: DNSDuration) -> Int {
        lhs.totalSeconds - rhs.totalSeconds
    }
    static func -= (lhs: DNSDuration, rhs: DNSDuration) -> Int { lhs - rhs }
}

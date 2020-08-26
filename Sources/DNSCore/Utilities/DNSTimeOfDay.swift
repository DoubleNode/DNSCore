//
//  DNSTimeOfDay.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public class DNSTimeOfDay: Hashable {
    var value: Float = 0

    public var hour: Int {
        return Int(value)
    }
    public var minutes: Int {
        return Int((value - Float(Int(value))) * 60)
    }

    public required init(timeValue: Float) {
        value = timeValue
    }

    public func timeAsString() -> String {
        let hour = self.hour % 12
        let amPm = (self.hour % 24) < 12 ? "a" : "p"

        var minStr = ""
        if self.minutes > 0 {
            minStr = String(format: ":%02d", self.minutes)
        }

        return "\((hour != 0) ? hour : 12)\(minStr)\(amPm)"
    }

    // MARK: - Hashable methods

    public static func == (lhs: DNSTimeOfDay, rhs: DNSTimeOfDay) -> Bool {
        return lhs.value == rhs.value
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

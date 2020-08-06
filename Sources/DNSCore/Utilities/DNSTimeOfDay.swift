//
//  DNSTimeOfDay.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public class DNSTimeOfDay {
    var value: Float = 0

    public required init(timeValue: Float) {
        value = timeValue
    }

    public func timeAsString() -> String {
        let hour = Int(value) % 12
        let min = Int((value - Float(Int(value))) * 60)
        let amPm = (Int(value) % 24) < 12 ? "a" : "p"

        var minStr = ""
        if min > 0 {
            minStr = String(format: ":%02d", min)
        }

        return "\((hour != 0) ? hour : 12)\(minStr)\(amPm)"
    }
}

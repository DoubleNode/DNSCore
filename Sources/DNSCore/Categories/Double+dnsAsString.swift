//
//  Double+dnsAsPrettyString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Double {
    var prettyString: String { self.asPrettyString() }
    func asPrettyString() -> String {
        let value = self
        let absValue = (value < 0) ? (0 - value) : value
        var countFormat = ""
        if absValue < 1000 {
            countFormat = "%03"
        } else if absValue < 10000 {
            countFormat = "%"
        } else {
            let valueK = value / 1000
            return String(format: "%0.1fK", valueK + 0.05)
        }
        let countInt = String(format: (countFormat + "d"), Int(value))
        let countFloat = String(format: (countFormat + ".1f"), value)
        let compareInt = String(format: "%d.0", Int(value))
        return (countFloat == compareInt) ? countInt : countFloat
    }
}

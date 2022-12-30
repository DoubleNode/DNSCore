//
//  Double+dnsAsFractionString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Double {
    var fractionString: String { self.asFractionString() }
    func asFractionString() -> String {
        var wholeStr = "\(Int(self))"
        var fractionStr = ""
        let fractionValue = self - Double(Int(self))
        switch fractionValue {
        case 0.25..<0.5:
            fractionStr = "¼"
        case 0.5..<0.75:
            fractionStr = "½"
        case 0.75..<1:
            fractionStr = "¾"
        default:
            break
        }
        if !fractionStr.isEmpty && wholeStr == "0" {
            wholeStr = ""
        }
        return wholeStr + fractionStr
    }
}

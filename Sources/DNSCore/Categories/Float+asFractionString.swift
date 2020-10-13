//
//  Date+dnsPretty.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Float {
    func asFractionString() -> String {
        var fractionStr = ""
        let fractionValue = self - Float(Int(self))
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
        return "\(Int(self))\(fractionStr)"
    }
}

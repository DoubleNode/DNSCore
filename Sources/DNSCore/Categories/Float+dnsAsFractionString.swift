//
//  Float+dnsAsFractionString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Float {
    var fractionString: String { self.asFractionString() }
    // swiftlint:disable:next cyclomatic_complexity
    func asFractionString() -> String {
        var wholeStr = "\(Int(self))"
        var fractionStr = ""
        let fractionValue = self - Float(Int(self))
        // ⅛ ⅙ ⅕ ¼ ⅓ ⅜ ⅖ ½ ⅗ ⅝ ⅔ ¾ ⅘ ⅚ ⅞
        switch fractionValue {
        case 0.125..<0.166:
            fractionStr = "⅛"
        case 0.166..<0.2:
            fractionStr = "⅙"
        case 0.2..<0.25:
            fractionStr = "⅕"
        case 0.25..<0.33:
            fractionStr = "¼"
        case 0.33..<0.375:
            fractionStr = "⅓"
        case 0.375..<0.4:
            fractionStr = "⅜"
        case 0.4..<0.5:
            fractionStr = "⅖"
        case 0.5..<0.6:
            fractionStr = "½"
        case 0.6..<0.625:
            fractionStr = "⅗"
        case 0.625..<0.66:
            fractionStr = "⅝"
        case 0.66..<0.75:
            fractionStr = "⅔"
        case 0.75..<0.8:
            fractionStr = "¾"
        case 0.8..<0.83:
            fractionStr = "⅘"
        case 0.83..<0.875:
            fractionStr = "⅚"
        case 0.875..<1:
            fractionStr = "⅞"
        default:
            break
        }
        if !fractionStr.isEmpty && wholeStr == "0" {
            wholeStr = ""
        }
        return wholeStr + fractionStr
    }
}

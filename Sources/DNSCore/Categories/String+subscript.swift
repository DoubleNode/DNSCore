//
//  String+subscript.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension String {
    subscript(i: Int) -> String {
        return self[i ..< i + 1]
    }
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, count) ..< count]
    }
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    subscript(rval: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, rval.lowerBound)),
                                            upper: min(count, max(0, rval.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

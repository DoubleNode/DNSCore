//
//  String+dnsSplit.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension String {
    func dnsSplit(every length:Int) -> [Substring] {
        guard length > 0 && length < count else {
            return [suffix(from:startIndex)]
        }

        return (0 ... (count - 1) / length)
            .map { dropFirst($0 * length).prefix(length) }
    }
    func dnsSplit(backwardsEvery length:Int) -> [Substring] {
        guard length > 0 && length < count else {
            return [suffix(from:startIndex)]
        }

        return (0 ... (count - 1) / length)
            .map { dropLast($0 * length).suffix(length) }
            .reversed()
    }
}

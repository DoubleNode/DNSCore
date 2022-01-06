//
//  Array+dnsRandom.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Array {
    @inlinable var dnsRandom: Element? {
        guard !self.isEmpty else { return nil }
        return self[Int.random(in: 0..<self.count)]
    }
}

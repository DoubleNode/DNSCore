//
//  Sequence+dnsUniqued.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Sequence where Element: Hashable {
    @discardableResult
    @inlinable mutating func dnsUniqued() -> Self {
        var set = Set<Element>()
        // swiftlint:disable:next force_cast
        self = filter { set.insert($0).inserted } as! Self
        return self
    }
    @inlinable func dnsUnique() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

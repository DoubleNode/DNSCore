//
//  DNSStack.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//
//  Based on code from the Swift Algorithm Club
//  Licensed under the MIT open source license
//  https://github.com/raywenderlich/swift-algorithm-club
//

import AtomicSwift
import Foundation

public struct DNSStack<T> {
    @Atomic
    fileprivate var array = [T]()

    public init() {}

    public var isEmpty: Bool {
        return array.isEmpty
    }
    public var count: Int {
        return array.count
    }
    public var items: [T] {
        return array
    }
    public mutating func empty() {
        array = [T]()
    }
    public mutating func push(_ element: T) {
        array.append(element)
    }
    @discardableResult
    public mutating func pop() -> T? {
        return array.popLast()
    }
    public var top: T? {
        return array.last
    }
}

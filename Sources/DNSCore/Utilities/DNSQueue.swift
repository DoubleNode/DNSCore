//
//  DNSQueue.swift
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

public struct DNSQueue<T> {
    @Atomic
    fileprivate var array = [T?]()
    @Atomic
    fileprivate var head = 0

    public init() {}

    public var isEmpty: Bool {
        return array.isEmpty
    }
    public var count: Int {
        return array.count - head
    }
    public mutating func empty() {
        array = [T?]()
        head = 0
    }
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    @discardableResult
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }

        array[head] = nil
        head += 1

        let percentage = Double(head)/Double(array.count)
        if (array.count > 50) && (percentage > 0.25) {
            array.removeFirst(head)
            head = 0
        }

        return element
    }
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}

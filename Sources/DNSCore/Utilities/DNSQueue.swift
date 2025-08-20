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

import Foundation
import os.lock

public struct DNSQueue<T>: @unchecked Sendable where T: Sendable {
    private struct QueueState {
        var array = [T?]()
        var head = 0
    }

    private let lock = OSAllocatedUnfairLock(initialState: QueueState())

    public init() {}

    public var isEmpty: Bool {
        lock.withLock { state in
            state.array.isEmpty
        }
    }

    public var count: Int {
        lock.withLock { state in
            state.array.count - state.head
        }
    }

    public mutating func empty() {
        lock.withLock { state in
            state.array = [T?]()
            state.head = 0
        }
    }

    public mutating func enqueue(_ element: T) {
        lock.withLock { state in
            state.array.append(element)
        }
    }

    @discardableResult
    public mutating func dequeue() -> T? {
        lock.withLock { state in
            guard state.head < state.array.count, let element = state.array[state.head] else {
                return nil
            }

            state.array[state.head] = nil
            state.head += 1

            let percentage = Double(state.head) / Double(state.array.count)
            if (state.array.count > 50) && (percentage > 0.25) {
                state.array.removeFirst(state.head)
                state.head = 0
            }

            return element
        }
    }

    public var front: T? {
        lock.withLock { state in
            if state.array.isEmpty || state.head >= state.array.count {
                return nil
            } else {
                return state.array[state.head]
            }
        }
    }
}

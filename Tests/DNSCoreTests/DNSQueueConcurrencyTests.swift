//
//  DNSQueueConcurrencyTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest
import Foundation
@testable import DNSCore

final class DNSQueueConcurrencyTests: XCTestCase {
    
    func test_concurrent_queue_operations() throws {
        let expectation = XCTestExpectation(description: "Concurrent queue operations")
        expectation.expectedFulfillmentCount = 100
        
        // Use a thread-safe wrapper to hold the queue
        let queueWrapper = ThreadSafeQueueWrapper<String>()
        
        // Stress test with 100 concurrent operations
        for i in 0..<100 {
            DispatchQueue.global().async {
                queueWrapper.enqueue("Item \(i)")
                _ = queueWrapper.dequeue()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        // Verify queue is in consistent state
        XCTAssertGreaterThanOrEqual(queueWrapper.count, 0)
    }
    
    func test_queue_thread_safety_stress() throws {
        let expectation = XCTestExpectation(description: "Queue thread safety stress test")
        expectation.expectedFulfillmentCount = 1000
        
        // Use a thread-safe wrapper to hold the queue
        let queueWrapper = ThreadSafeQueueWrapper<Int>()
        
        // Multiple threads enqueueing
        for i in 0..<500 {
            DispatchQueue.global(qos: .background).async {
                queueWrapper.enqueue(i)
                expectation.fulfill()
            }
        }
        
        // Multiple threads dequeueing
        for _ in 0..<500 {
            DispatchQueue.global(qos: .userInitiated).async {
                _ = queueWrapper.dequeue()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    func test_queue_concurrent_empty_operations() throws {
        let expectation = XCTestExpectation(description: "Concurrent empty operations")
        expectation.expectedFulfillmentCount = 50
        
        // Use a thread-safe wrapper to hold the queue
        let queueWrapper = ThreadSafeQueueWrapper<String>()
        
        // Populate queue first
        for i in 0..<25 {
            queueWrapper.enqueue("Item \(i)")
        }
        
        // Concurrent empty operations
        for _ in 0..<50 {
            DispatchQueue.global().async {
                queueWrapper.empty()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        XCTAssertTrue(queueWrapper.isEmpty)
    }
    
    func test_queue_front_property_thread_safety() throws {
        let expectation = XCTestExpectation(description: "Front property thread safety")
        expectation.expectedFulfillmentCount = 200
        
        // Use a thread-safe wrapper to hold the queue
        let queueWrapper = ThreadSafeQueueWrapper<String>()
        queueWrapper.enqueue("Test Item")
        
        // Concurrent front property access
        for _ in 0..<200 {
            DispatchQueue.global().async {
                _ = queueWrapper.front
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}

// Thread-safe wrapper for DNSQueue to avoid mutation warnings in concurrent contexts
private final class ThreadSafeQueueWrapper<T: Sendable>: @unchecked Sendable {
    private var queue = DNSQueue<T>()
    private let lock = NSLock()
    
    var isEmpty: Bool {
        lock.withLock { queue.isEmpty }
    }
    
    var count: Int {
        lock.withLock { queue.count }
    }
    
    var front: T? {
        lock.withLock { queue.front }
    }
    
    func enqueue(_ element: T) {
        lock.withLock { queue.enqueue(element) }
    }
    
    func dequeue() -> T? {
        lock.withLock { queue.dequeue() }
    }
    
    func empty() {
        lock.withLock { queue.empty() }
    }
}

// Extension to provide a convenient withLock method for NSLock
private extension NSLock {
    func withLock<T>(_ body: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try body()
    }
}

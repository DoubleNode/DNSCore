//
//  DNSSubscriberEnvelopeConcurrencyTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest
import Combine
import Foundation
@testable import DNSCore

final class DNSSubscriberEnvelopeConcurrencyTests: XCTestCase {
    
    func test_concurrent_subscriber_operations() throws {
        let expectation = XCTestExpectation(description: "Concurrent subscriber operations")
        expectation.expectedFulfillmentCount = 100
        
        // Test concurrent subscriber envelope operations
        for _ in 0..<100 {
            DispatchQueue.global().async {
                let subject = PassthroughSubject<String, Never>()
                let cancellable = subject.sink { _ in }
                
                let envelope = DNSSubscriberEnvelope(with: cancellable)
                envelope.close()
                
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_static_subscribers_thread_safety() throws {
        let expectation = XCTestExpectation(description: "Static subscribers thread safety")
        expectation.expectedFulfillmentCount = 200
        
        // Test concurrent access to static subscribers array
        for _ in 0..<100 {
            DispatchQueue.global(qos: .background).async {
                let subject = PassthroughSubject<Int, Never>()
                let cancellable = subject.sink { _ in }
                let envelope = DNSSubscriberEnvelope(with: cancellable)
                XCTAssertNotNil(envelope)
                expectation.fulfill()
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                let currentSubscribers = DNSSubscriberEnvelope.subscribers
                XCTAssertNotNil(currentSubscribers)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    func test_envelope_open_close_thread_safety() throws {
        let expectation = XCTestExpectation(description: "Envelope open/close thread safety")
        expectation.expectedFulfillmentCount = 200
        
        // Test concurrent open/close operations
        for _ in 0..<100 {
            DispatchQueue.global(qos: .background).async {
                let subject = PassthroughSubject<String, Never>()
                let cancellable = subject.sink { _ in }
                let envelope = DNSSubscriberEnvelope()
                envelope.open(with: cancellable)
                expectation.fulfill()
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                let envelope = DNSSubscriberEnvelope()
                envelope.close()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 15.0)
    }
}

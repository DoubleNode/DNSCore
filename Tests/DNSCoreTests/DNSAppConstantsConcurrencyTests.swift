//
//  DNSAppConstantsConcurrencyTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest
import Foundation
@testable import DNSCore

final class DNSAppConstantsConcurrencyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        DNSAppConstants.resetPlistDictionary()
    }
    
    func test_concurrent_shared_access() throws {
        let expectation = XCTestExpectation(description: "Concurrent shared access")
        expectation.expectedFulfillmentCount = 100
        
        // Test concurrent access to shared instance
        for _ in 0..<100 {
            DispatchQueue.global().async {
                let shared = DNSAppConstants.shared
                XCTAssertNotNil(shared)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_concurrent_plist_operations() throws {
        let expectation = XCTestExpectation(description: "Concurrent plist operations")
        expectation.expectedFulfillmentCount = 200
        
        // Test concurrent plist config operations
        for i in 0..<100 {
            DispatchQueue.global(qos: .background).async {
                _ = DNSAppConstants.plistConfigValue(replace: "test_key_\(i)", with: "test_value_\(i)")
                expectation.fulfill()
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                _ = DNSAppConstants.plistConfigValue(for: "test_key_\(i)")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    func test_concurrent_reset_operations() throws {
        let expectation = XCTestExpectation(description: "Concurrent reset operations")
        expectation.expectedFulfillmentCount = 50
        
        // Test concurrent reset operations
        for _ in 0..<50 {
            DispatchQueue.global().async {
                DNSAppConstants.resetPlistDictionary()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_concurrent_merge_operations() throws {
        let expectation = XCTestExpectation(description: "Concurrent merge operations")
        expectation.expectedFulfillmentCount = 100
        
        let shared = DNSAppConstants.shared
        
        // Test concurrent merge operations
        for i in 0..<100 {
            DispatchQueue.global().async {
                let constants = ["merge_key_\(i)": "merge_value_\(i)"]
                shared.merge(constants: constants)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}

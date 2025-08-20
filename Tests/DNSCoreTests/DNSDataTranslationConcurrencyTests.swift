//
//  DNSDataTranslationConcurrencyTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest
import Foundation
@testable import DNSCore

final class DNSDataTranslationConcurrencyTests: XCTestCase {
    
    func test_concurrent_token_operations() throws {
        let expectation = XCTestExpectation(description: "Concurrent token operations")
        expectation.expectedFulfillmentCount = 300
        
        let translator = DNSDataTranslation()
        
        // Concurrent add operations
        for i in 0..<100 {
            DispatchQueue.global(qos: .background).async {
                translator.addTokenReplacement(token: "token_\(i)", replacement: "replacement_\(i)")
                expectation.fulfill()
            }
        }
        
        // Concurrent remove operations
        for i in 0..<100 {
            DispatchQueue.global(qos: .userInitiated).async {
                translator.removeTokenReplacement(token: "token_\(i)")
                expectation.fulfill()
            }
        }
        
        // Concurrent clear operations
        for _ in 0..<100 {
            DispatchQueue.global(qos: .utility).async {
                translator.clearTokenReplacements()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    func test_concurrent_formatter_access() throws {
        let expectation = XCTestExpectation(description: "Concurrent formatter access")
        expectation.expectedFulfillmentCount = 100
        
        // Test concurrent access to static formatters
        for _ in 0..<100 {
            DispatchQueue.global().async {
                _ = DNSDataTranslation.defaultNumberFormatter
                _ = DNSDataTranslation.defaultCurrencyFormatter
                _ = DNSDataTranslation.defaultDateFormatter1
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}

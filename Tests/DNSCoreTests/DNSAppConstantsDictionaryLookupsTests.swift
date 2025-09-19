//
//  DNSAppConstantsDictionaryLookupsTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSAppConstantsDictionaryLookupsTests: XCTestCase {
    private var sut: DNSAppConstants!

    override func setUp() {
        super.setUp()
        sut = DNSAppConstants()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_dictionaryLookup_withValidConstantAndKey_shouldReturnValue() {
        // Create test data similar to how DNSAppConstants works
        sut.merge(constants: [
            "TestDictionary": [
                "testKey": "testValue",
                "anotherKey": "anotherValue"
            ]
        ])

        let result = DNSAppConstants.dictionaryLookup(fromConstant: "TestDictionary", for: "testKey")
        XCTAssertEqual(result, "testValue")
    }

    func test_dictionaryLookup_withInvalidConstant_shouldReturnEmptyString() {
        let result = DNSAppConstants.dictionaryLookup(fromConstant: "NonExistentConstant", for: "testKey")
        XCTAssertEqual(result, "")
    }

    func test_dictionaryLookup_withInvalidKey_shouldReturnEmptyString() {
        sut.merge(constants: [
            "TestDictionary": [
                "validKey": "validValue"
            ]
        ])

        let result = DNSAppConstants.dictionaryLookup(fromConstant: "TestDictionary", for: "invalidKey")
        XCTAssertEqual(result, "")
    }

    func test_dictionaryLookup_withEmptyConstant_shouldReturnEmptyString() {
        let result = DNSAppConstants.dictionaryLookup(fromConstant: "", for: "testKey")
        XCTAssertEqual(result, "")
    }
}

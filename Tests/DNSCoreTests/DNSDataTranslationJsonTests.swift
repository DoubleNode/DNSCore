//
//  DNSDataTranslationJsonTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationJsonTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_string_withJSONString_shouldReturnString() {
        let jsonString = "{\"key\": \"value\"}"
        let result = sut.string(from: jsonString)
        XCTAssertEqual(result, jsonString)
    }

    func test_bool_withJSONBoolean_shouldReturnBool() {
        let boolValue = false
        let result = sut.bool(from: boolValue)
        XCTAssertEqual(result, boolValue)
    }

    func test_int_withJSONNumber_shouldReturnInt() {
        let intValue = 100
        let result = sut.int(from: intValue)
        XCTAssertEqual(result, intValue)
    }
}

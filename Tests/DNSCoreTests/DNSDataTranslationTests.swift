//
//  DNSDataTranslationTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_initialization_shouldCreateInstance() {
        XCTAssertNotNil(sut)
    }

    func test_string_withString_shouldReturnSameString() {
        let testString = "Test String"
        let result = sut.string(from: testString)
        XCTAssertEqual(result, testString)
    }

    func test_string_withNil_shouldReturnNil() {
        let result: String? = sut.string(from: nil as String?)
        XCTAssertNil(result)
    }

    func test_bool_withTrue_shouldReturnTrue() {
        let result = sut.bool(from: true)
        XCTAssertEqual(result, true)
    }

    func test_bool_withFalse_shouldReturnFalse() {
        let result = sut.bool(from: false)
        XCTAssertEqual(result, false)
    }

    func test_int_withInteger_shouldReturnSameInteger() {
        let testInt = 42
        let result = sut.int(from: testInt)
        XCTAssertEqual(result, testInt)
    }
}

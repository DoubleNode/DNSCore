//
//  DNSDataTranslationUIntTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationUIntTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_uint_withPositiveInteger_shouldReturnUInt() {
        let testValue: Int = 42
        let result = sut.uint(from: testValue)
        XCTAssertEqual(result, UInt(42))
    }

    func test_uint_withUIntString_shouldReturnUInt() {
        let testString = "123"
        let result = sut.uint(from: testString)
        XCTAssertEqual(result, UInt(123))
    }

    func test_uint_withNegativeInteger_shouldReturnNil() {
        let testValue: Int = -42
        let result = sut.uint(from: testValue)
        XCTAssertNil(result)
    }

    func test_uint_withInvalidString_shouldReturnNil() {
        let testString = "not a number"
        let result = sut.uint(from: testString)
        XCTAssertNil(result)
    }
}

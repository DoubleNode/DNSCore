//
//  DNSDataTranslationUIColorTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationUIColorTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_string_withColorString_shouldReturnString() {
        let colorString = "systemRed"
        let result = sut.string(from: colorString)
        XCTAssertEqual(result, colorString)
    }

    func test_bool_withBooleanValue_shouldReturnBool() {
        let boolValue = true
        let result = sut.bool(from: boolValue)
        XCTAssertEqual(result, boolValue)
    }

    func test_double_withDoubleValue_shouldReturnDouble() {
        let doubleValue = 3.14
        let result = sut.double(from: doubleValue)
        XCTAssertEqual(result, doubleValue)
    }
}

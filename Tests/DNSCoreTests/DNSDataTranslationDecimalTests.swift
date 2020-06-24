//
//  DNSDataTranslationDecimalTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationDecimalTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_decimal_withAnyNil_shouldReturnNil() {
        let value: Any? = nil
        let result: Decimal? = sut.decimal(from: value)
        XCTAssertNil(result)
    }
    func test_decimal_withTestStruct_shouldReturnDecimal0() {
        struct TestStruct {
        }

        let value: Any? = TestStruct()
        let result: Decimal? = sut.decimal(from: value)
        XCTAssertEqual(result, Decimal(0))
    }
    func test_decimal_withDecimalNil_shouldReturnDecimal0() {
        let value: Decimal? = nil
        let result: Decimal? = sut.decimal(from: value)
        XCTAssertEqual(result, Decimal(0))
    }
    func test_decimal_withDecimal10_shouldReturnDecimal10() {
        let value: Decimal? = 10
        let result: Decimal? = sut.decimal(from: value)
        XCTAssertEqual(result, Decimal(10))
    }
    func test_decimal_withNSNumberNil_shouldReturnDecimal0() {
        let value: NSNumber? = nil
        let result: Decimal? = sut.decimal(from: value)
        XCTAssertEqual(result, Decimal(0))
    }
    func test_decimal_withNSNumber20_shouldReturnDecimal20() {
        let value: NSNumber? = 20
        let result: Decimal? = sut.decimal(from: value)
        XCTAssertEqual(result, Decimal(20))
    }
    func test_decimal_withStringEmpty_shouldReturnDecimal0() {
        let value: String? = ""
        let result: Decimal? = sut.decimal(from: value)
        XCTAssertEqual(result, Decimal(0))
    }
    func test_decimal_withString23_shouldReturnDecimal23() {
        let value: String? = "23"
        let result: Decimal? = sut.decimal(from: value)
        XCTAssertEqual(result, Decimal(23))
    }
    func test_decimal_withStringCurrency138_shouldReturnDecimal138() {
        let value: String? = "$128"
        let result: Decimal? = sut.decimal(from: value, DNSDataTranslation.defaultCurrencyFormatter)
        XCTAssertEqual(result, Decimal(128))
    }
}

//
//  DNSDataTranslationDoubleTests.swift
//  DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationDoubleTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_double_withAnyNil_shouldReturnNil() {
        let value: Any? = nil
        let result: Double? = sut.double(from: value)
        XCTAssertNil(result)
    }
    func test_double_withTestStruct_shouldReturnNil() {
        struct TestStruct {
        }

        let value: Any? = TestStruct()
        let result: Double? = sut.double(from: value)
        XCTAssertNil(result)
    }
}

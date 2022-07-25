//
//  DNSDataTranslationIntTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationIntTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_int_withAnyNil_shouldReturnNil() {
        let value: Any? = nil
        let result: Int? = sut.int(from: value)
        XCTAssertNil(result)
    }
    func test_int_withTestStruct_shouldReturnNil() {
        struct TestStruct {
        }

        let value: Any? = TestStruct()
        let result: Int? = sut.int(from: value)
        XCTAssertNil(result)
    }
}

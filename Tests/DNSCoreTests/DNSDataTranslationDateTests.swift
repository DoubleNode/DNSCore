//
//  DNSDataTranslationDateTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationDateTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_date_withAnyNil_shouldReturnNil() {
        let value: Any? = nil
        let result: Date? = sut.date(from: value)
        XCTAssertNil(result)
    }
    func test_date_withTestStruct_shouldReturnNil() {
        struct TestStruct {
        }

        let value: Any? = TestStruct()
        let result: Date? = sut.date(from: value)
        XCTAssertNil(result)
    }
}

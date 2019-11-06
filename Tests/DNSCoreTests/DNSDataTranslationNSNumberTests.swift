//
//  DNSDataTranslationNSNumberTests.m
//  DNSCoreTests
//
//  Created by Darren Ehlers on 10/23/16.
//  Copyright © 2019 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationNSNumberTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_number_withAnyNil_shouldReturnNil() {
        let value: Any? = nil
        let result: NSNumber? = sut.number(from: value)
        XCTAssertNil(result)
    }
    func test_number_withTestStruct_shouldReturnNil() {
        struct TestStruct {
        }

        let value: Any? = TestStruct()
        let result: NSNumber? = sut.number(from: value)
        XCTAssertNil(result)
    }
}

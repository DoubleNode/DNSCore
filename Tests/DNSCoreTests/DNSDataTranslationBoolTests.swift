//
//  DNSDataTranslationBoolTests.m
//  DNSCoreTests
//
//  Created by Darren Ehlers on 10/23/16.
//  Copyright © 2019 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationBoolTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_bool_withAnyNil_shouldReturnFalse() {
        let value: Any? = nil
        let result: Bool = sut.bool(from: value) ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withAnyTestStruct_shouldReturnFalse() {
        struct TestStruct {
        }

        let value: Any? = TestStruct()
        let result: Bool = sut.bool(from: value) ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withBoolNil_shouldReturnFalse() {
        let value: Bool? = nil
        let result: Bool = sut.bool(from: value) ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withBoolFalse_shouldReturnFalse() {
        let result: Bool = sut.bool(from: false) ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withBoolTrue_shouldReturnTrue() {
        let result: Bool = sut.bool(from: true) ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withNSNumberNil_shouldReturnFalse() {
        let value: NSNumber? = nil
        let result: Bool = sut.bool(from: value) ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withNSNumber0_shouldReturnFalse() {
        let result: Bool = sut.bool(from: NSNumber(0)) ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withNSNumber1_shouldReturnTrue() {
        let result: Bool = sut.bool(from: NSNumber(1)) ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withNSNumber10_shouldReturnTrue() {
        let result: Bool = sut.bool(from: NSNumber(10)) ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withStringNil_shouldReturnFalse() {
        let value: String? = nil
        let result: Bool = sut.bool(from: value) ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withStringYES_shouldReturnTrue() {
        let result: Bool = sut.bool(from: "YES") ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withStringYes_shouldReturnTrue() {
        let result: Bool = sut.bool(from: "Yes") ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withStringyes_shouldReturnTrue() {
        let result: Bool = sut.bool(from: "yes") ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withStringNO_shouldReturnFalse() {
        let result: Bool = sut.bool(from: "NO") ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withStringNo_shouldReturnFalse() {
        let result: Bool = sut.bool(from: "No") ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withStringno_shouldReturnFalse() {
        let result: Bool = sut.bool(from: "no") ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withStringTRUE_shouldReturnTrue() {
        let result: Bool = sut.bool(from: "TRUE") ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withStringTrue_shouldReturnTrue() {
        let result: Bool = sut.bool(from: "True") ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withStringtrue_shouldReturnTrue() {
        let result: Bool = sut.bool(from: "true") ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withStringFALSE_shouldReturnFalse() {
        let result: Bool = sut.bool(from: "FALSE") ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withStringFalse_shouldReturnFalse() {
        let result: Bool = sut.bool(from: "False") ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withStringfalse_shouldReturnFalse() {
        let result: Bool = sut.bool(from: "false") ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withString0_shouldReturnFalse() {
        let result: Bool = sut.bool(from: "0") ?? false
        XCTAssertEqual(result, false)
    }
    func test_bool_withString1_shouldReturnTrue() {
        let result: Bool = sut.bool(from: "1") ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withString10_shouldReturnTrue() {
        let result: Bool = sut.bool(from: "10") ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withStringPlus_shouldReturnTrue() {
        let result: Bool = sut.bool(from: "+") ?? false
        XCTAssertEqual(result, true)
    }
    func test_bool_withStringMinus_shouldReturnFalse() {
        let result: Bool = sut.bool(from: "-") ?? false
        XCTAssertEqual(result, false)
    }
}

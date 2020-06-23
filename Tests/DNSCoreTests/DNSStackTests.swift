//
//  DNSStackTests.swift
//  DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSStackTests: XCTestCase {

    private var sut: DNSStack<Int>!

    override func setUp() {
        super.setUp()
        sut = DNSStack<Int>()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_isEmpty_withEmptyQueue_shouldReturnTrue() {
        let result: Bool = sut.isEmpty
        XCTAssertTrue(result, "Array is not Empty!")
    }
    func test_isEmpty_withNotEmptyQueue_shouldReturnFalse() {
        sut.push(5)
        let result: Bool = sut.isEmpty
        XCTAssertFalse(result, "Array is Empty!")
    }
    func test_count_withEmptyQueue_shouldReturn0() {
        let result: Int = sut.count
        XCTAssertEqual(result, 0)
    }
    func test_count_with3Items_shouldReturn3() {
        sut.push(5)
        sut.push(3)
        sut.push(126)
        let result: Int = sut.count
        XCTAssertEqual(result, 3)
    }
    func test_push_with4Items_shouldNotCrash() {
        sut.push(5)
        sut.push(3)
        sut.push(126)
        sut.push(73)
        let result: Int = sut.count
        XCTAssertEqual(result, 4)
    }
    func test_pop_with4Items_shouldReturnValue73Then126Then3() {
        sut.push(5)
        sut.push(3)
        sut.push(126)
        sut.push(73)
        var result: Int? = sut.pop()
        XCTAssertEqual(result, 73)
        result = sut.pop()
        XCTAssertEqual(result, 126)
        result = sut.pop()
        XCTAssertEqual(result, 3)
    }
    func test_top_with4ItemsDequeu3_shouldReturnValue5AndCount1() {
        sut.push(5)
        sut.push(3)
        sut.push(126)
        sut.push(73)
        var result: Int? = sut.pop()
        result = sut.pop()
        result = sut.pop()
        result = sut.top
        XCTAssertEqual(result, 5)

        let count: Int = sut.count
        XCTAssertEqual(count, 1)
    }
}

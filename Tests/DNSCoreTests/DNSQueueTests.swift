//
//  DNSQueueTests.swift
//  DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSQueueTests: XCTestCase {

    private var sut: DNSQueue<Int>!

    override func setUp() {
        super.setUp()
        sut = DNSQueue<Int>()
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
        sut.enqueue(5)
        let result: Bool = sut.isEmpty
        XCTAssertFalse(result, "Array is Empty!")
    }
    func test_count_withEmptyQueue_shouldReturn0() {
        let result: Int = sut.count
        XCTAssertEqual(result, 0)
    }
    func test_count_with3Items_shouldReturn3() {
        sut.enqueue(5)
        sut.enqueue(3)
        sut.enqueue(126)
        let result: Int = sut.count
        XCTAssertEqual(result, 3)
    }
    func test_enqueue_with4Items_shouldNotCrash() {
        sut.enqueue(5)
        sut.enqueue(3)
        sut.enqueue(126)
        sut.enqueue(73)
        let result: Int = sut.count
        XCTAssertEqual(result, 4)
    }
    func test_dequeue_with4Items_shouldReturnValue5Then3Then126() {
        sut.enqueue(5)
        sut.enqueue(3)
        sut.enqueue(126)
        sut.enqueue(73)
        var result: Int? = sut.dequeue()
        XCTAssertEqual(result, 5)
        result = sut.dequeue()
        XCTAssertEqual(result, 3)
        result = sut.dequeue()
        XCTAssertEqual(result, 126)
    }
    func test_front_with4ItemsDequeu3_shouldReturnValue73AndCount1() {
        sut.enqueue(5)
        sut.enqueue(3)
        sut.enqueue(126)
        sut.enqueue(73)
        var result: Int? = sut.dequeue()
        result = sut.dequeue()
        result = sut.dequeue()
        result = sut.front
        XCTAssertEqual(result, 73)

        let count: Int = sut.count
        XCTAssertEqual(count, 1)
    }
}

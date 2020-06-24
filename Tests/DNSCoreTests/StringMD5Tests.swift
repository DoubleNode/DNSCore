//
//  StringMD5Tests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class StringMD5Tests: XCTestCase {
    private var sut: String!

    override func setUp() {
        super.setUp()
        sut = String()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_dnsMD5_withEmptyString_shouldReturnMD5String() {
        let result: String = sut.dnsMD5()
        XCTAssertEqual(result, "d41d8cd98f00b204e9800998ecf8427e")
    }
    func test_dnsMD5_withStringDoubleNode_shouldReturnMD5String() {
        sut = "DoubleNode"
        let result: String = sut.dnsMD5()
        XCTAssertEqual(result, "a213e2eee28f2b529191999a9533613a")
    }
}

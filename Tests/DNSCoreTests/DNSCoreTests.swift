//
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSCoreTests: XCTestCase {
    private var sut: DNSCore!

    override func setUp() {
        super.setUp()
        sut = DNSCore()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_zero() {
        XCTFail("Tests not yet implemented in DNSCoreTests")
    }
}

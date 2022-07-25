//
//  DNSAppSystemTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSAppSystemTests: XCTestCase {
    private var sut: DNSAppSystem!

    override func setUp() {
        super.setUp()
        sut = DNSAppSystem(code: "TEST", name: "Test System")
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_zero() {
        XCTFail("Tests not yet implemented in DNSAppSystemTests")
    }
}

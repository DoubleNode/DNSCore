//
//  DNSAppSystemTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
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

    func test_init_withCodeAndName_shouldInitializeProperties() {
        XCTAssertEqual(sut.code, "TEST")
        XCTAssertEqual(sut.name, "Test System")
        XCTAssertEqual(sut.status, .green)
    }

    func test_statusDefault_shouldBeGreen() {
        let newSystem = DNSAppSystem(code: "NEW", name: "New System")
        XCTAssertEqual(newSystem.status, .green)
    }

    func test_statusChange_shouldUpdateCorrectly() {
        sut.status = .yellow
        XCTAssertEqual(sut.status, .yellow)

        sut.status = .red
        XCTAssertEqual(sut.status, .red)
    }

    func test_multipleInstances_shouldMaintainSeparateState() {
        let system1 = DNSAppSystem(code: "SYS1", name: "System 1")
        let system2 = DNSAppSystem(code: "SYS2", name: "System 2")

        system1.status = .red
        system2.status = .yellow

        XCTAssertEqual(system1.status, .red)
        XCTAssertEqual(system2.status, .yellow)
        XCTAssertNotEqual(system1.code, system2.code)
    }
}

//
//  DNSDeviceTests.swift
//  DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDeviceTests: XCTestCase {
    private var sut: DNSDevice!

    override func setUp() {
        super.setUp()
        sut = DNSDevice()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_zero() {
        XCTFail("Tests not yet implemented in DNSDeviceTests")
    }
}

//
//  DNSAppConstantsDefaultsTests.swift
//  DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSAppConstantsDefaultsTests: XCTestCase {
    private var sut: DNSAppConstants!

    override func setUp() {
        super.setUp()
        sut = DNSAppConstants()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_zero() {
        XCTFail("Tests not yet implemented in DNSAppConstantsDefaultsTests")
    }
}

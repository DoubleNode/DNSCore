//
//  DNSRootViewControllerTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSRootViewControllerTests: XCTestCase {
    private var sut: DNSRootViewController!

    override func setUp() {
        super.setUp()
        sut = DNSRootViewController()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_zero() {
        XCTFail("Tests not yet implemented in DNSRootViewControllerTests")
    }
}

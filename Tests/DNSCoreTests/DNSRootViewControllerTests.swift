//
//  DNSRootViewControllerTests.m
//  DNSCoreTests
//
//  Created by Darren Ehlers on 10/23/16.
//  Copyright © 2019 - 2016 DoubleNode.com. All rights reserved.
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

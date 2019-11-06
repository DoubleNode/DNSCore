//
//  DNSAppGlobalsTests.m
//  DNSCoreTests
//
//  Created by Darren Ehlers on 10/23/16.
//  Copyright © 2019 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSAppGlobalsTests: XCTestCase {
    private var sut: DNSAppGlobals!

    override func setUp() {
        super.setUp()
        sut = DNSAppGlobals()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_zero() {
        XCTFail("Tests not yet implemented in DNSAppGlobalsTests")
    }
}

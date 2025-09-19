//
//  DNSAppConstantsDefaultsTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
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

    func test_sharedInstance_shouldNotBeNil() {
        XCTAssertNotNil(DNSAppConstants.shared)
    }

    func test_uniqueDeviceId_shouldNotBeEmpty() {
        let result = DNSAppConstants.uniqueDeviceId
        XCTAssertFalse(result.isEmpty)
        XCTAssertTrue(result.contains("iOS"))
    }

    func test_targetType_shouldNotBeEmpty() {
        let result = DNSAppConstants.targetType
        XCTAssertFalse(result.isEmpty)
    }

    func test_defaultAppAPIType_shouldReturnUnknown() {
        let result = sut.appAPITypeRead()
        XCTAssertEqual(result, .unknown)
    }

    func test_defaultAppBuildType_shouldReturnUnknown() {
        let result = sut.appBuildTypeRead()
        XCTAssertEqual(result, .unknown)
    }

    func test_defaultAppEnvType_shouldReturnUnknown() {
        let result = sut.appEnvTypeRead()
        XCTAssertEqual(result, .unknown)
    }
}

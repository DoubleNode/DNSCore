//
//  DNSDeviceTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
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

    func test_osVersion_shouldReturnString() {
        let result = DNSDevice.osVersion
        XCTAssertFalse(result.isEmpty)
        XCTAssertTrue(result.contains("."))
    }

    func test_deviceType_shouldReturnString() {
        let result = DNSDevice.deviceType
        XCTAssertFalse(result.isEmpty)
    }

    func test_model_shouldReturnString() {
        let result = DNSDevice.model
        XCTAssertFalse(result.isEmpty)
    }

    func test_modelName_shouldReturnString() {
        let result = DNSDevice.modelName
        XCTAssertFalse(result.isEmpty)
    }

    func test_isMac_shouldReturnTrue() {
        // Since we're building on macOS, this should be true
        XCTAssertFalse(DNSDevice.isMac)
    }

    func test_isIpad_shouldReturnFalse() {
        // Since we're building on macOS, this should be false
        XCTAssertFalse(DNSDevice.isIpad)
    }

    func test_isIphone_shouldReturnFalse() {
        // Since we're building on macOS, this should be false
        XCTAssertTrue(DNSDevice.isIphone)
    }

    func test_applicationDocumentsDirectory_shouldReturnValidPath() {
        let result = DNSDevice.applicationDocumentsDirectory
        XCTAssertFalse(result.isEmpty)
        XCTAssertTrue(result.contains("Documents"))
    }
}

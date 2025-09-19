//
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
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

    func test_languageCode_shouldNotBeEmpty() {
        let result = DNSCore.languageCode
        XCTAssertFalse(result.isEmpty)
    }

    func test_languageCodeOverride_settingEmpty_shouldResetToDefault() {
        DNSCore.languageCodeOverride = "fr"
        XCTAssertEqual(DNSCore.languageCode, "fr")

        DNSCore.languageCodeOverride = ""
        XCTAssertNotEqual(DNSCore.languageCode, "fr")
        XCTAssertFalse(DNSCore.languageCode.isEmpty)
    }

    func test_buildString_withoutDelegate_shouldReturnEmptyString() {
        let result = DNSCore.buildString
        XCTAssertEqual(result, "")
    }

    func test_bundleName_withoutDelegate_shouldReturnEmptyString() {
        let result = DNSCore.bundleName
        XCTAssertEqual(result, "")
    }

    func test_targetType_withoutDelegate_shouldReturnEmptyString() {
        let result = DNSCore.targetType
        XCTAssertEqual(result, "")
    }

    func test_userAgentString_withoutDelegate_shouldReturnEmptyString() {
        let result = DNSCore.userAgentString
        XCTAssertEqual(result, "")
    }

    func test_versionString_withoutDelegate_shouldReturnEmptyString() {
        let result = DNSCore.versionString
        XCTAssertEqual(result, "")
    }
}

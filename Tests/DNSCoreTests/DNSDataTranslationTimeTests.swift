//
//  DNSDataTranslationTimeTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationTimeTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1633803600      // 2021-10-09T18:20:41+00:00
    static let defaultDateTimeString: String = "10/09/2021 06:20 PM CST"
    
    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultString = defaultDateTimeString

    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_dnsDataTranslationTime_withDefaultAndFormatFullSimple_shouldReturnString() {
        let testString = self.defaultString
        let result = self.sut.time(from: testString)
        XCTAssertEqual(result, self.defaultDate)
    }
}

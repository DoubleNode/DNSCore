//
//  DNSDataTranslationURLTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSDataTranslationURLTests: XCTestCase {
    private var sut: DNSDataTranslation!

    override func setUp() {
        super.setUp()
        sut = DNSDataTranslation()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_url_withValidURL_shouldReturnURL() {
        let testURLString = "https://www.example.com"
        let testURL = URL(string: testURLString)
        let result = sut.url(from: testURLString)
        XCTAssertEqual(result, testURL)
    }

    func test_url_withInvalidURL_shouldReturnNil() {
        let invalidURLString = "not a valid url"
        let result = sut.url(from: invalidURLString)
        XCTAssertNil(result)
    }

    func test_url_withEmptyString_shouldReturnNil() {
        let result = sut.url(from: "")
        XCTAssertNil(result)
    }
}

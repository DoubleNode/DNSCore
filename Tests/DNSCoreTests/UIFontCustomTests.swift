//
//  UIFontCustomTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

#if !os(macOS)
class UIFontCustomTests: XCTestCase {
    private var sut: UIFont!

    override func setUp() {
        super.setUp()
        sut = UIFont()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_dnsCustom_withAppleColorEmoji215_shouldReturnFontAppleColorEmoji215() {
        let result: UIFont = UIFont.dnsCustom(with: "AppleColorEmoji", and: 21.5)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.pointSize, 21.5)
        XCTAssertEqual(result.familyName, "Apple Color Emoji")
    }
    func test_dnsDumpFonts_with_shouldNotThrowErrors() {
        XCTAssertNoThrow(UIFont.dnsDumpFonts())
    }
}
#endif

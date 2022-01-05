//
//  DatePrettyTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1665339641      // 2022-10-09T18:20:41+00:00
    static let defaultDateYear: String = "2022"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00
    
    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateYear = DatePrettyTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)

    private var sut: Date!

    override func setUp() {
        super.setUp()
        NSTimeZone.default = TimeZone(abbreviation: "CDT")!
        sut = Date()
    }
    override func tearDown() {
        sut = nil
        NSTimeZone.resetSystemTimeZone()
        super.tearDown()
    }

    func test_dnsDate_withDefaultAndDefaultFormat_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate()
        XCTAssertEqual(result, "Oct 9")
    }
    func test_dnsDateTime_withDefaultAndDefaultFormat_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime()
        XCTAssertEqual(result, "Oct 9 @ 1:20pm")
    }
    func test_dnsTime_withDefaultAndDefaultFormat_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime()
        XCTAssertEqual(result, "1:20pm")
    }
    func test_dnsDate_withDefaultAndEndDateDefaultFormat_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) - Sep 3, 2031")
    }
    func test_dnsTime_withDefaultAndEndDateDefaultFormat_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) @ 1:20pm - Sep 3, 2031 @ 11:32am")
    }
}

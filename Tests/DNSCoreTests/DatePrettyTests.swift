//
//  DatePrettyTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = {
        let currentYear = Calendar.current.component(.year, from: Date())
        var components = DateComponents(year: currentYear, month: 10, day: 9, hour: 13, minute: 20, second: 41)
        components.timeZone = TimeZone(abbreviation: "CDT")
        return Calendar.current.date(from: components)?.timeIntervalSince1970 ?? 0
    }()
    static let defaultDateYear: String = "\(Calendar.current.component(.year, from: Date()))"
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
        XCTAssertEqual(result, "Oct 9 - Sep 3, 2031")
    }
    func test_dnsTime_withDefaultAndEndDateDefaultFormat_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end)
        XCTAssertEqual(result, "Oct 9 @ 1:20pm - Sep 3, 2031 @ 11:32am")
    }
}

//
//  DatePrettyLongTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyLongTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1633803641      // 2021-10-09T18:20:41+00:00
    static let defaultDateYear: String = "2021"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00
    static let defaultSimilarEndDateTimeIntervalSince1970: TimeInterval = 1635448038   // 2021-10-28T19:07:18+00:00

    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateYear = DatePrettyLongTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)
    let defaultSimilarEndDate = Date(timeIntervalSince1970: defaultSimilarEndDateTimeIntervalSince1970)

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

    func test_dnsDate_withDefaultAndFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .longSimple)
        XCTAssertEqual(result, "October 9, \(defaultDateYear)")
    }
    func test_dnsDate_withDefaultAndFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .longSmart)
        XCTAssertEqual(result, "October 9")
    }
    func test_dnsDate_withNowAndFormatLongPretty_shouldReturnString() {
        let result: String = sut.dnsDate(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }

    func test_dnsDateTime_withDefaultAndFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longSimple)
        XCTAssertEqual(result, "October 9, \(defaultDateYear) at 1:20:41pm CDT")
    }
    func test_dnsDateTime_withDefaultAndFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longSmart)
        XCTAssertEqual(result, "October 9 @ 1:20:41pm CDT")
    }
    func test_dnsDateTime_withNowAndFormatLongPretty_shouldReturnString() {
        let result: String = sut.dnsDateTime(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.justNow)
    }

    func test_dnsTime_withDefaultAndFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longSimple)
        XCTAssertEqual(result, "1:20:41pm CDT")
    }
    func test_dnsTime_withDefaultAndFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longSmart)
        XCTAssertEqual(result, "1:20:41pm CDT")
    }
    func test_dnsTime_withNowAndFormatLongPretty_shouldReturnString() {
        let result: String = sut.dnsTime(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.justNow)
    }

    func test_dnsDate_withDefaultAndEndDateFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .longSimple)
        XCTAssertEqual(result, "October 9, \(defaultDateYear) - September 3, 2031")
    }
    func test_dnsDate_withDefaultAndEndDateFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .longSmart)
        XCTAssertEqual(result, "October 9, \(defaultDateYear) - September 3, 2031")
    }
    func test_dnsDate_withNowAndEndDateFormatLongPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .longPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today) \(C.Localizations.DatePretty.to) September 3, 2031")
    }

    func test_dnsTime_withDefaultAndEndDateFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longSimple)
        XCTAssertEqual(result, "October 9, \(defaultDateYear) at 1:20:41pm CDT - September 3, 2031 at 11:32:21am CDT")
    }
    func test_dnsTime_withDefaultAndSimilarEndDateFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultSimilarEndDate
        let result: String = sut.dnsTime(to: end, as: .longSmart)
        XCTAssertEqual(result, "October 9 @ 1:20:41pm CDT - October 28 @ 2:07:18pm CDT")
    }
    func test_dnsTime_withDefaultAndEndDateFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longSmart)
        XCTAssertEqual(result, "October 9, \(defaultDateYear) @ 1:20:41pm CDT - September 3, 2031 @ 11:32:21am CDT")
    }
    func test_dnsTime_withNowAndEndDateFormatLongPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.justNow) \(C.Localizations.DatePretty.to) September 3, 2031")
    }
}

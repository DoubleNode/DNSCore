//
//  DatePrettyFullTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyFullTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1602267641      // 2020-10-09T18:20:41+00:00
    static let defaultDateTimezone: String = "Central Daylight Time"
    static let defaultDateDay: String = "Friday"
    static let defaultDateMonth: String = "October"
    static let defaultDateYear: String = "2020"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00

    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateTimezone = DatePrettyFullTests.defaultDateTimezone
    let defaultDateDay = DatePrettyFullTests.defaultDateDay
    let defaultDateMonth = DatePrettyFullTests.defaultDateMonth
    let defaultDateYear = DatePrettyFullTests.defaultDateYear
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

    func test_dnsDate_withDefaultAndFormatFullSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .fullSimple)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear)")
    }
    func test_dnsDate_withDefaultAndFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .fullSmart)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9")
    }
    func test_dnsDate_withNowAndFormatFullPretty_shouldReturnString() {
        let result: String = sut.dnsDate(as: .fullPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }

    func test_dnsTime_withDefaultAndFormatFullSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .fullSimple)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) at 1:20:41pm \(defaultDateTimezone)")
    }
    func test_dnsTime_withDefaultAndFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .fullSmart)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 \(C.Localizations.DatePretty.at) 1:20:41pm \(defaultDateTimezone)")
    }
    func test_dnsTime_withNowAndFormatFullPretty_shouldReturnString() {
        let result: String = sut.dnsTime(as: .fullPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.justNow)
    }

    func test_dnsDate_withDefaultAndEndDateFormatFullSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .fullSimple)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) - Wednesday, September 3, 2031")
    }
    func test_dnsDate_withDefaultAndEndDateFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .fullSmart)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) - Wednesday, September 3, 2031")
    }
    func test_dnsDate_withNowAndEndDateFormatFullPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .fullPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today) \(C.Localizations.DatePretty.to) Wednesday, September 3, 2031")
    }

    func test_dnsTime_withDefaultAndEndDateFormatFullSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullSimple)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) at 1:20:41pm \(defaultDateTimezone) - " +
            "Wednesday, September 3, 2031 at 11:32:21am \(defaultDateTimezone)")
    }
    func test_dnsTime_withDefaultAndEndDateFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullSmart)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) \(C.Localizations.DatePretty.at) 1:20:41pm \(defaultDateTimezone) - " +
            "Wednesday, September 3, 2031 \(C.Localizations.DatePretty.at) 11:32:21am \(defaultDateTimezone)")
    }
    func test_dnsTime_withNowAndEndDateFormatFullPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.justNow) \(C.Localizations.DatePretty.to) Wednesday, September 3, 2031")
    }
}

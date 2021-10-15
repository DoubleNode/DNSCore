//
//  DatePrettyFullTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyFullTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1633803641      // 2021-10-09T18:20:41+00:00
    static let defaultDateTimezone: String = "Central Daylight Time"
    static let defaultDateDay: String = "Saturday"
    static let defaultDateMonth: String = "October"
    static let defaultDateYear: String = "2021"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00
    static let secondaryTimeZone = TimeZone(abbreviation: "EDT")!
    static let secondaryTimeZoneString: String = "Eastern Daylight Time"

    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateTimezone = DatePrettyFullTests.defaultDateTimezone
    let defaultDateDay = DatePrettyFullTests.defaultDateDay
    let defaultDateMonth = DatePrettyFullTests.defaultDateMonth
    let defaultDateYear = DatePrettyFullTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)
    let secondaryTimeZone = DatePrettyFullTests.secondaryTimeZone
    let secondaryTimeZoneString = DatePrettyFullTests.secondaryTimeZoneString

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

    func test_dnsDateTime_withDefaultAndFormatFullSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .fullSimple)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) at 1:20:41pm")
    }
    func test_dnsDateTime_withDefaultAndFormatFullSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .fullSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) at 2:20:41pm \(secondaryTimeZoneString)")
    }
    func test_dnsDateTime_withDefaultAndFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .fullSmart)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 \(C.Localizations.DatePretty.at) 1:20:41pm")
    }
    func test_dnsDateTime_withDefaultAndFormatFullSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .fullSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 \(C.Localizations.DatePretty.at) 2:20:41pm \(secondaryTimeZoneString)")
    }
    func test_dnsDateTime_withNowAndFormatFullPretty_shouldReturnString() {
        let result: String = sut.dnsDateTime(as: .fullPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.justNow)
    }

    func test_dnsTime_withDefaultAndFormatFullSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .fullSimple)
        XCTAssertEqual(result, "1:20:41pm")
    }
    func test_dnsTime_withDefaultAndFormatFullSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .fullSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "2:20:41pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .fullSmart)
        XCTAssertEqual(result, "1:20:41pm")
    }
    func test_dnsTime_withDefaultAndFormatFullSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .fullSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "2:20:41pm \(secondaryTimeZoneString)")
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
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) at 1:20:41pm - " +
            "Wednesday, September 3, 2031 at 11:32:21am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatFullSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) at 2:20:41pm - " +
                       "Wednesday, September 3, 2031 at 12:32:21pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndEndDateFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullSmart)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) \(C.Localizations.DatePretty.at) 1:20:41pm - " +
            "Wednesday, September 3, 2031 \(C.Localizations.DatePretty.at) 11:32:21am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatFullSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) \(C.Localizations.DatePretty.at) 2:20:41pm - " +
                       "Wednesday, September 3, 2031 \(C.Localizations.DatePretty.at) 12:32:21pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withNowAndEndDateFormatFullPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.justNow) \(C.Localizations.DatePretty.to) Wednesday, September 3, 2031")
    }
}

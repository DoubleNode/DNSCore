//
//  DatePrettyShortTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyShortTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1633803641      // 2021-10-09T18:20:41+00:00
    static let defaultDateTimezone: String = "CDT"
    static let defaultDateYear: String = "21"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00
    static let defaultEndFromNowDateTimeIntervalSinceNow: TimeInterval = 86400 * 5
    static let secondaryTimeZone = TimeZone(abbreviation: "EDT")!
    static let secondaryTimeZoneString: String = "EDT"

    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateTimezone = DatePrettyShortTests.defaultDateTimezone
    let defaultDateYear = DatePrettyShortTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)
    let defaultEndFromNowDate = Date(timeIntervalSinceNow: defaultEndFromNowDateTimeIntervalSinceNow)
    let secondaryTimeZone = DatePrettyShortTests.secondaryTimeZone
    let secondaryTimeZoneString = DatePrettyShortTests.secondaryTimeZoneString

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

    func test_dnsDate_withDefaultAndFormatShortSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .shortSimple)
        XCTAssertEqual(result, "10/9/\(defaultDateYear)")
    }
    func test_dnsDate_withDefaultAndFormatShortSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .shortSmart)
        XCTAssertEqual(result, "10/9")
    }
    func test_dnsDate_withNowAndFormatShortPretty_shouldReturnString() {
        struct TestInterval {
            let start: TimeInterval
            let result: String
        }
        let testIntervals: [TestInterval] = [
            TestInterval(start: 0 - Date.Seconds.deltaOneMinute,
                         result: C.Localizations.DatePretty.todayShort),
            TestInterval(start: 0 - Date.Seconds.deltaThreeMinutes,
                         result: C.Localizations.DatePretty.todayShort),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek,
                         result: String(format: C.Localizations.DatePretty.weekAgoShort, "\(1)")),
        ]
        for testInterval in testIntervals {
            sut = Date(timeIntervalSinceNow: testInterval.start + (testInterval.start > 0 ? 20 : -20))
            let result: String = sut.dnsDate(as: .shortPretty)
            XCTAssertEqual(result, testInterval.result)
        }
    }

    func test_dnsDateTime_withDefaultAndFormatShortSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .shortSimple)
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 1:20pm")
    }
    func test_dnsDateTime_withDefaultAndFormatShortSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .shortSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsDateTime_withDefaultAndFormatShortSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .shortSmart)
        XCTAssertEqual(result, "10/9 @ 1:20pm")
    }
    func test_dnsDateTime_withDefaultAndFormatShortSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .shortSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "10/9 @ 2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsDateTime_withNowAndFormatShortPretty_shouldReturnString() {
        struct TestInterval {
            let start: TimeInterval
            let result: String
        }
        let testIntervals: [TestInterval] = [
            TestInterval(start: 0 - Date.Seconds.deltaOneMinute,
                         result: String(format: C.Localizations.DatePretty.minuteAgoShort, "\(1)")),
            TestInterval(start: 0 - Date.Seconds.deltaThreeMinutes,
                         result: C.Localizations.DatePretty.minutesAgoShort),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek,
                         result: String(format: C.Localizations.DatePretty.weekAgoShort, "\(1)")),
        ]
        for testInterval in testIntervals {
            sut = Date(timeIntervalSinceNow: testInterval.start + (testInterval.start > 0 ? 20 : -20))
            let result: String = sut.dnsDateTime(as: .shortPretty)
            XCTAssertEqual(result, testInterval.result)
        }
    }

    func test_dnTime_withDefaultAndFormatShortSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .shortSimple)
        XCTAssertEqual(result, "1:20pm")
    }
    func test_dnTime_withDefaultAndFormatShortSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .shortSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndFormatShortSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .shortSmart)
        XCTAssertEqual(result, "1:20pm")
    }
    func test_dnsTime_withDefaultAndFormatShortSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .shortSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withNowAndFormatShortPretty_shouldReturnString() {
        struct TestInterval {
            let start: TimeInterval
            let result: String
        }
        let testIntervals: [TestInterval] = [
            TestInterval(start: 0 - Date.Seconds.deltaOneMinute,
                         result: String(format: C.Localizations.DatePretty.minuteAgoShort, "\(1)")),
            TestInterval(start: 0 - Date.Seconds.deltaThreeMinutes,
                         result: C.Localizations.DatePretty.minutesAgoShort),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek,
                         result: String(format: C.Localizations.DatePretty.weekAgoShort, "\(1)")),
        ]
        for testInterval in testIntervals {
            sut = Date(timeIntervalSinceNow: testInterval.start + (testInterval.start > 0 ? 20 : -20))
            let result: String = sut.dnsTime(as: .shortPretty)
            XCTAssertEqual(result, testInterval.result)
        }
    }

    func test_dnsDate_withDefaultAndEndDateFormatShortSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .shortSimple)
        XCTAssertEqual(result, "10/9/\(defaultDateYear) - 9/3/31")
    }
    func test_dnsDate_withDefaultAndEndDateFormatShortSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .shortSmart)
        XCTAssertEqual(result, "10/9/\(defaultDateYear) - 9/3/31")
    }
    func test_dnsDate_withNowAndEndDateFormatShortPretty_shouldReturnString() {
        struct TestInterval {
            let start: TimeInterval
            let end: TimeInterval
            let result: String
        }
        let testIntervals: [TestInterval] = [
            TestInterval(start: 0 - Date.Seconds.deltaOneMinute, end: Date.Seconds.deltaTwoHours,
                         result: C.Localizations.DatePretty.todayShort),
            TestInterval(start: 0 - Date.Seconds.deltaThreeMinutes, end: Date.Seconds.deltaOneDay,
                         result: "\(C.Localizations.DatePretty.todayShort) - \(C.Localizations.DatePretty.tomorrowShort)"),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek, end: Date.Seconds.deltaSixMinutes,
                         result: String(format: C.Localizations.DatePretty.weekAgoShort, "\(1)") + " - \(C.Localizations.DatePretty.todayShort)"),
        ]
        for testInterval in testIntervals {
            sut = Date(timeIntervalSinceNow: testInterval.start + (testInterval.start > 0 ? 20 : -20))
            let end = Date(timeIntervalSinceNow:  testInterval.end + (testInterval.end > 0 ? 20 : -20))
            let result: String = sut.dnsDate(to: end, as: .shortPretty)
            XCTAssertEqual(result, testInterval.result)
        }
    }

    func test_dnTime_withDefaultAndEndDateFormatShortSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .shortSimple)
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 1:20pm - 9/3/31, 11:32am")
    }
    func test_dnTime_withDefaultAndEndDateFormatShortSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .shortSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 2:20pm - 9/3/31, 12:32pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndEndDateFormatShortSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .shortSmart)
        XCTAssertEqual(result, "10/9/\(defaultDateYear) @ 1:20pm - 9/3/31 @ 11:32am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatShortSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .shortSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "10/9/\(defaultDateYear) @ 2:20pm - 9/3/31 @ 12:32pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withEndDateFormatShortPretty_shouldReturnString() {
        struct TestInterval {
            let start: TimeInterval
            let end: TimeInterval
            let result: String
        }
        let testIntervals: [TestInterval] = [
            TestInterval(start: 0 - Date.Seconds.deltaOneMinute, end: Date.Seconds.deltaTwoHours,
                         result: String(format: C.Localizations.DatePretty.minuteAgoShort, "\(1)") + " - " +
                            String(format: C.Localizations.DatePretty.hoursShort, "\(2)")),
            TestInterval(start: 0 - Date.Seconds.deltaThreeMinutes, end: Date.Seconds.deltaOneDay,
                         result: String(format: C.Localizations.DatePretty.minutesAgoShort, "\(3)") + " - " +
                            C.Localizations.DatePretty.tomorrowShort),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek, end: Date.Seconds.deltaSixMinutes,
                         result: String(format: C.Localizations.DatePretty.weekAgoShort, "\(1)") + " - " +
                            String(format: C.Localizations.DatePretty.minutesAbbrev, "\(6)")),
        ]
        for testInterval in testIntervals {
            sut = Date(timeIntervalSinceNow: testInterval.start + (testInterval.start > 0 ? 20 : -20))
            let end = Date(timeIntervalSinceNow:  testInterval.end + (testInterval.end > 0 ? 20 : -20))
            let result: String = sut.dnsTime(to: end, as: .shortPretty)
            XCTAssertEqual(result, testInterval.result)
        }
    }
}

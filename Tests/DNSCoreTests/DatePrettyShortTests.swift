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
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1665339641      // 2022-10-09T18:20:41+00:00
    static let defaultDateTimezone: String = "CDT"
    static let defaultDateYear: String = "22"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00
    static let defaultEndFromNowDateTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaOneDay * 5
    static let defaultEndFromSameDayDateTimeIntervalSince1970: TimeInterval = defaultDateTimeIntervalSince1970 + Date.Seconds.deltaOneHour * 2
    static let nowEndFromNowSameDayDateTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaOneHour * 2
    static let nowTenMinutesAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaTenMinutes
    static let nowFortyFiveMinutesAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaFourtyFiveMinutes
    static let nowThreeHoursAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaThreeHours
    static let nowTenMinutesInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaTenMinutes
    static let nowFortyFiveMinutesInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaFourtyFiveMinutes
    static let nowThreeHoursInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaThreeHours
    static let secondaryTimeZone = TimeZone(abbreviation: "EDT")!
    static let secondaryTimeZoneString: String = "EDT"

    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateTimezone = DatePrettyShortTests.defaultDateTimezone
    let defaultDateYear = DatePrettyShortTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)
    let defaultEndFromNowDate = Date(timeIntervalSinceNow: defaultEndFromNowDateTimeIntervalSinceNow)
    let defaultEndFromSameDayDate = Date(timeIntervalSince1970: defaultEndFromSameDayDateTimeIntervalSince1970)
    let nowEndFromNowSameDayDate = Date(timeIntervalSinceNow: nowEndFromNowSameDayDateTimeIntervalSinceNow)
    let nowTenMinutesAgo = Date(timeIntervalSinceNow: nowTenMinutesAgoTimeIntervalSinceNow)
    let nowFortyFiveMinutesAgo = Date(timeIntervalSinceNow: nowFortyFiveMinutesAgoTimeIntervalSinceNow)
    let nowThreeHoursAgo = Date(timeIntervalSinceNow: nowThreeHoursAgoTimeIntervalSinceNow)
    let nowTenMinutesIn = Date(timeIntervalSinceNow: nowTenMinutesInTimeIntervalSinceNow)
    let nowFortyFiveMinutesIn = Date(timeIntervalSinceNow: nowFortyFiveMinutesInTimeIntervalSinceNow)
    let nowThreeHoursIn = Date(timeIntervalSinceNow: nowThreeHoursInTimeIntervalSinceNow)
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
    func test_dnsDate_withNowTenMinutesAgoAndFormatShortPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsDate(as: .shortPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.todayShort)
    }
    func test_dnsDate_withNowFortyFiveMinutesAgoAndFormatShortPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsDate(as: .shortPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.todayShort)
    }
    func test_dnsDate_withNowThreeHoursAgoAndFormatShortPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsDate(as: .shortPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.todayShort)
    }
    func test_dnsDate_withNowTenMinutesInAndFormatShortPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsDate(as: .shortPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.todayShort)
    }
    func test_dnsDate_withNowFortyFiveMinutesInAndFormatShortPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsDate(as: .shortPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.todayShort)
    }
    func test_dnsDate_withNowThreeHoursInAndFormatShortPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsDate(as: .shortPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.todayShort)
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
        XCTAssertEqual(result, "10/9, 1:20pm")
    }
    func test_dnsDateTime_withDefaultAndFormatShortSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .shortSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "10/9, 2:20pm \(secondaryTimeZoneString)")
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
                         result: String(format: C.Localizations.DatePretty.minutesAgoShort, "\(3)+")),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek,
                         result: String(format: C.Localizations.DatePretty.weekAgoShort, "\(1)")),
        ]
        for testInterval in testIntervals {
            sut = Date(timeIntervalSinceNow: testInterval.start + (testInterval.start > 0 ? 20 : -20))
            let result: String = sut.dnsDateTime(as: .shortPretty)
            XCTAssertEqual(result, testInterval.result)
        }
    }
    func test_dnsDateTime_withNowTenMinutesAgoAndFormatShortPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsDateTime(as: .shortPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.todayShort), \(String(format: C.Localizations.DatePretty.minutesAgoShort, "10"))")
    }
    func test_dnsDateTime_withNowFortyFiveMinutesAgoAndFormatShortPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsDateTime(as: .shortPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.todayShort), \(String(format: C.Localizations.DatePretty.minutesAgoShort, "45"))")
    }
    func test_dnsDateTime_withNowThreeHoursAgoAndFormatShortPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsDateTime(as: .shortPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.todayShort), \(String(format: C.Localizations.DatePretty.hoursAgoShort, "3+"))")
    }
    func test_dnsDateTime_withNowTenMinutesInAndFormatShortPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsDateTime(as: .shortPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.todayShort), \(String(format: C.Localizations.DatePretty.inMinutesShort, "9"))")
    }
    func test_dnsDateTime_withNowFortyFiveMinutesInAndFormatShortPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsDateTime(as: .shortPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.todayShort), \(String(format: C.Localizations.DatePretty.inMinutesShort, "44"))")
    }
    func test_dnsDateTime_withNowThreeHoursInAndFormatShortPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsDateTime(as: .shortPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.todayShort), \(String(format: C.Localizations.DatePretty.inHoursShort, "2"))")
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
                         result: String(format: C.Localizations.DatePretty.minutesAgoShort, "\(3)+")),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek,
                         result: String(format: C.Localizations.DatePretty.weekAgoShort, "\(1)")),
        ]
        for testInterval in testIntervals {
            sut = Date(timeIntervalSinceNow: testInterval.start + (testInterval.start > 0 ? 20 : -20))
            let result: String = sut.dnsTime(as: .shortPretty)
            XCTAssertEqual(result, testInterval.result)
        }
    }
    func test_dnsTime_withNowTenMinutesAgoAndFormatShortPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsTime(as: .shortPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgoShort, "10"))
    }
    func test_dnsTime_withNowFortyFiveMinutesAgoAndFormatShortPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsTime(as: .shortPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgoShort, "45"))
    }
    func test_dnsTime_withNowThreeHoursAgoAndFormatShortPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsTime(as: .shortPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.hoursAgoShort, "3+"))
    }
    func test_dnsTime_withNowTenMinutesInAndFormatShortPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsTime(as: .shortPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutesShort, "9"))
    }
    func test_dnsTime_withNowFortyFiveMinutesInAndFormatShortPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsTime(as: .shortPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutesShort, "44"))
    }
    func test_dnsTime_withNowThreeHoursInAndFormatShortPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsTime(as: .shortPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inHoursShort, "2"))
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
                         result: String(format: C.Localizations.DatePretty.minutesAgoShort, "\(3)+") + " - " +
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

    func test_dnTime_withDefaultAndEndDateSameDayFormatShortSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndFromSameDayDate
        let result: String = sut.dnsTime(to: end, as: .shortSimple)
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 1:20pm - 10/9/\(defaultDateYear), 3:20pm")
    }
    func test_dnTime_withDefaultAndEndDateSameDayFormatShortSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndFromSameDayDate
        let result: String = sut.dnsTime(to: end, as: .shortSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 2:20pm - 10/9/\(defaultDateYear), 4:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndEndDateSameDayFormatShortSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndFromSameDayDate
        let result: String = sut.dnsTime(to: end, as: .shortSmart)
        XCTAssertEqual(result, "10/9/\(defaultDateYear) @ 1:20pm - 3:20pm")
    }
    func test_dnsTime_withDefaultAndEndDateSameDayFormatShortSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndFromSameDayDate
        let result: String = sut.dnsTime(to: end, as: .shortSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "10/9/\(defaultDateYear) @ 2:20pm - 4:20pm\(secondaryTimeZoneString)")
    }

    func test_dnTime_withNowAndEndDateSameDayFormatShortSimple_shouldReturnString() {
        let end = nowEndFromNowSameDayDate
        let result: String = sut.dnsTime(to: end, as: .shortSimple)
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 1:20pm - 10/9/\(defaultDateYear), 3:20pm")
    }
    func test_dnTime_withNowAndEndDateSameDayFormatShortSimpleWithTimezone_shouldReturnString() {
        let end = nowEndFromNowSameDayDate
        let result: String = sut.dnsTime(to: end, as: .shortSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 2:20pm - 10/9/\(defaultDateYear), 4:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withNowAndEndDateSameDayFormatShortSmart_shouldReturnString() {
        let end = nowEndFromNowSameDayDate
        let result: String = sut.dnsTime(to: end, as: .shortSmart)
        XCTAssertEqual(result, "10/9/\(defaultDateYear) @ 1:20pm - 3:20pm")
    }
    func test_dnsTime_withNowAndEndDateSameDayFormatShortSmartWithTimezone_shouldReturnString() {
        let end = nowEndFromNowSameDayDate
        let result: String = sut.dnsTime(to: end, as: .shortSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "10/9/\(defaultDateYear) @ 2:20pm - 4:20pm\(secondaryTimeZoneString)")
    }
}

//
//  DatePrettyNormalTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyNormalTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1633803641      // 2021-10-09T18:20:41+00:00
    static let defaultDateTimezone: String = "CDT"
    static let defaultDateYear: String = "2021"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00
    static let nowTenMinutesAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaTenMinutes
    static let nowFortyFiveMinutesAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaFourtyFiveMinutes
    static let nowThreeHoursAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaThreeHours
    static let nowTenMinutesInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaTenMinutes
    static let nowFortyFiveMinutesInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaFourtyFiveMinutes
    static let nowThreeHoursInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaThreeHours
    static let secondaryTimeZone = TimeZone(abbreviation: "EDT")!
    static let secondaryTimeZoneString: String = "EDT"

    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateTimezone = DatePrettyNormalTests.defaultDateTimezone
    let defaultDateYear = DatePrettyNormalTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)
    let nowTenMinutesAgo = Date(timeIntervalSinceNow: nowTenMinutesAgoTimeIntervalSinceNow)
    let nowFortyFiveMinutesAgo = Date(timeIntervalSinceNow: nowFortyFiveMinutesAgoTimeIntervalSinceNow)
    let nowThreeHoursAgo = Date(timeIntervalSinceNow: nowThreeHoursAgoTimeIntervalSinceNow)
    let nowTenMinutesIn = Date(timeIntervalSinceNow: nowTenMinutesInTimeIntervalSinceNow)
    let nowFortyFiveMinutesIn = Date(timeIntervalSinceNow: nowFortyFiveMinutesInTimeIntervalSinceNow)
    let nowThreeHoursIn = Date(timeIntervalSinceNow: nowThreeHoursInTimeIntervalSinceNow)
    let secondaryTimeZone = DatePrettyNormalTests.secondaryTimeZone
    let secondaryTimeZoneString = DatePrettyNormalTests.secondaryTimeZoneString

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

    func test_dnsDate_withDefaultAndFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear)")
    }
    func test_dnsDate_withDefaultAndFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .normalSmart)
        XCTAssertEqual(result, "Oct 9")
    }
    func test_dnsDate_withNowAndFormatNormalPretty_shouldReturnString() {
        let result: String = sut.dnsDate(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowTenMinutesAgoAndFormatNormalPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsDate(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowFortyFiveMinutesAgoAndFormatNormalPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsDate(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowThreeHoursAgoAndFormatNormalPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsDate(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowTenMinutesInAndFormatNormalPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsDate(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowFortyFiveMinutesInAndFormatNormalPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsDate(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowThreeHoursInAndFormatNormalPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsDate(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }

    func test_dnsDateTime_withDefaultAndFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) @ 1:20pm")
    }
    func test_dnsDateTime_withDefaultAndFormatNormalSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .normalSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) @ 2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsDateTime_withDefaultAndFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .normalSmart)
        XCTAssertEqual(result, "Oct 9 @ 1:20pm")
    }
    func test_dnsDateTime_withDefaultAndFormatNormalSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .normalSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "Oct 9 @ 2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsDateTime_withNowAndFormatNormalPretty_shouldReturnString() {
        let result: String = sut.dnsDateTime(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.justNow)
    }
    func test_dnsDateTime_withNowTenMinutesAgoAndFormatNormalPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsDateTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgoAbbrev, "10"))
    }
    func test_dnsDateTime_withNowFortyFiveMinutesAgoAndFormatNormalPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsDateTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgoAbbrev, "45"))
    }
    func test_dnsDateTime_withNowThreeHoursAgoAndFormatNormalPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsDateTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.hoursAgo, "3+"))
    }
    func test_dnsDateTime_withNowTenMinutesInAndFormatNormalPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsDateTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutesAbbrev, "9"))
    }
    func test_dnsDateTime_withNowFortyFiveMinutesInAndFormatNormalPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsDateTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutesAbbrev, "44"))
    }
    func test_dnsDateTime_withNowThreeHoursInAndFormatNormalPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsDateTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inHours, "2"))
    }

    func test_dnsTime_withDefaultAndFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .normalSimple)
        XCTAssertEqual(result, "1:20pm")
    }
    func test_dnsTime_withDefaultAndFormatNormalSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .normalSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .normalSmart)
        XCTAssertEqual(result, "1:20pm")
    }
    func test_dnsTime_withDefaultAndFormatNormalSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .normalSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withNowAndFormatNormalPretty_shouldReturnString() {
        let result: String = sut.dnsTime(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.justNow)
    }
    func test_dnsTime_withNowTenMinutesAgoAndFormatNormalPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgoAbbrev, "10"))
    }
    func test_dnsTime_withNowFortyFiveMinutesAgoAndFormatNormalPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgoAbbrev, "45"))
    }
    func test_dnsTime_withNowThreeHoursAgoAndFormatNormalPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.hoursAgo, "3+"))
    }
    func test_dnsTime_withNowTenMinutesInAndFormatNormalPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutesAbbrev, "9"))
    }
    func test_dnsTime_withNowFortyFiveMinutesInAndFormatNormalPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutesAbbrev, "44"))
    }
    func test_dnsTime_withNowThreeHoursInAndFormatNormalPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsTime(as: .normalPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inHours, "2"))
    }

    func test_dnsDate_withDefaultAndEndDateFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) - Sep 3, 2031")
    }
    func test_dnsDate_withDefaultAndEndDateFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .normalSmart)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) - Sep 3, 2031")
    }
    func test_dnsDate_withNowAndEndDateFormatNormalPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .normalPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today) - 9/3/31")
    }

    func test_dnsTime_withDefaultAndEndDateFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) @ 1:20pm - Sep 3, 2031 @ 11:32am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatNormalSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) @ 2:20pm - Sep 3, 2031 @ 12:32pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndEndDateFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalSmart)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) @ 1:20pm - Sep 3, 2031 @ 11:32am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatNormalSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) @ 2:20pm - Sep 3, 2031 @ 12:32pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withNowAndEndDateFormatNormalPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.justNow) - 9/3/31")
    }
}

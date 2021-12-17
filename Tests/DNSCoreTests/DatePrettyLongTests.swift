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
    static let defaultDateTimezone: String = "CDT"
    static let defaultDateYear: String = "2021"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00
    static let defaultSimilarEndDateTimeIntervalSince1970: TimeInterval = 1635448038   // 2021-10-28T19:07:18+00:00
    static let nowTenMinutesAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaTenMinutes
    static let nowFortyFiveMinutesAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaFourtyFiveMinutes
    static let nowThreeHoursAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaThreeHours
    static let nowTenMinutesInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaTenMinutes
    static let nowFortyFiveMinutesInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaFourtyFiveMinutes
    static let nowThreeHoursInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaThreeHours
    static let secondaryTimeZone = TimeZone(abbreviation: "EDT")!
    static let secondaryTimeZoneString: String = "EDT"

    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateTimezone = DatePrettyLongTests.defaultDateTimezone
    let defaultDateYear = DatePrettyLongTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)
    let defaultSimilarEndDate = Date(timeIntervalSince1970: defaultSimilarEndDateTimeIntervalSince1970)
    let nowTenMinutesAgo = Date(timeIntervalSinceNow: nowTenMinutesAgoTimeIntervalSinceNow)
    let nowFortyFiveMinutesAgo = Date(timeIntervalSinceNow: nowFortyFiveMinutesAgoTimeIntervalSinceNow)
    let nowThreeHoursAgo = Date(timeIntervalSinceNow: nowThreeHoursAgoTimeIntervalSinceNow)
    let nowTenMinutesIn = Date(timeIntervalSinceNow: nowTenMinutesInTimeIntervalSinceNow)
    let nowFortyFiveMinutesIn = Date(timeIntervalSinceNow: nowFortyFiveMinutesInTimeIntervalSinceNow)
    let nowThreeHoursIn = Date(timeIntervalSinceNow: nowThreeHoursInTimeIntervalSinceNow)
    let secondaryTimeZone = DatePrettyLongTests.secondaryTimeZone
    let secondaryTimeZoneString = DatePrettyLongTests.secondaryTimeZoneString

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
    func test_dnsDate_withNowTenMinutesAgoAndFormatLongPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsDate(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowFortyFiveMinutesAgoAndFormatLongPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsDate(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowThreeHoursAgoAndFormatLongPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsDate(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowTenMinutesInAndFormatLongPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsDate(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowFortyFiveMinutesInAndFormatLongPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsDate(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowThreeHoursInAndFormatLongPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsDate(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }

    func test_dnsDateTime_withDefaultAndFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longSimple)
        XCTAssertEqual(result, "October 9, \(defaultDateYear) at 1:20pm")
    }
    func test_dnsDateTime_withDefaultAndFormatLongSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "October 9, \(defaultDateYear) at 2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsDateTime_withDefaultAndFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longSmart)
        XCTAssertEqual(result, "October 9 @ 1:20:41pm")
    }
    func test_dnsDateTime_withDefaultAndFormatLongSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "October 9 @ 2:20:41pm \(secondaryTimeZoneString)")
    }
    func test_dnsDateTime_withDefaultAndFormatLongPretty_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longPretty)
        XCTAssertEqual(result, "October 9, 2021 at 1:20PM")
    }
    func test_dnsDateTime_withNowAndFormatLongPretty_shouldReturnString() {
        let result: String = sut.dnsDateTime(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.justNow)
    }
    func test_dnsDateTime_withNowTenMinutesAgoAndFormatLongPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsDateTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgo, "10"))
    }
    func test_dnsDateTime_withNowFortyFiveMinutesAgoAndFormatLongPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsDateTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgo, "45"))
    }
    func test_dnsDateTime_withNowThreeHoursAgoAndFormatLongPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsDateTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.hoursAgo, "3"))
    }
    func test_dnsDateTime_withNowTenMinutesInAndFormatLongPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsDateTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutes, "9"))
    }
    func test_dnsDateTime_withNowFortyFiveMinutesInAndFormatLongPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsDateTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutes, "44"))
    }
    func test_dnsDateTime_withNowThreeHoursInAndFormatLongPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsDateTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inHours, "2"))
    }

    func test_dnsTime_withDefaultAndFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longSimple)
        XCTAssertEqual(result, "1:20pm")
    }
    func test_dnsTime_withDefaultAndFormatLongSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longSmart)
        XCTAssertEqual(result, "1:20:41pm")
    }
    func test_dnsTime_withDefaultAndFormatLongSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "2:20:41pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withNowAndFormatLongPretty_shouldReturnString() {
        let result: String = sut.dnsTime(as: .longPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.justNow)
    }
    func test_dnsTime_withNowTenMinutesAgoAndFormatLongPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgo, "10"))
    }
    func test_dnsTime_withNowFortyFiveMinutesAgoAndFormatLongPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgo, "45"))
    }
    func test_dnsTime_withNowThreeHoursAgoAndFormatLongPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.hoursAgo, "3"))
    }
    func test_dnsTime_withNowTenMinutesInAndFormatLongPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutes, "9"))
    }
    func test_dnsTime_withNowFortyFiveMinutesInAndFormatLongPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutes, "44"))
    }
    func test_dnsTime_withNowThreeHoursInAndFormatLongPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsTime(as: .longPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inHours, "2"))
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
        XCTAssertEqual(result, "October 9, \(defaultDateYear) at 1:20pm - September 3, 2031 at 11:32am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatLongSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "October 9, \(defaultDateYear) at 2:20pm - September 3, 2031 at 12:32pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndSimilarEndDateFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultSimilarEndDate
        let result: String = sut.dnsTime(to: end, as: .longSmart)
        XCTAssertEqual(result, "October 9 @ 1:20:41pm - October 28 @ 2:07:18pm")
    }
    func test_dnsTime_withDefaultAndSimilarEndDateFormatLongSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultSimilarEndDate
        let result: String = sut.dnsTime(to: end, as: .longSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "October 9 @ 2:20:41pm - October 28 @ 3:07:18pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndEndDateFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longSmart)
        XCTAssertEqual(result, "October 9, \(defaultDateYear) @ 1:20:41pm - September 3, 2031 @ 11:32:21am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatLongSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "October 9, \(defaultDateYear) @ 2:20:41pm - September 3, 2031 @ 12:32:21pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withNowAndEndDateFormatLongPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.justNow) \(C.Localizations.DatePretty.to) September 3, 2031 at 11:32AM")
    }
}

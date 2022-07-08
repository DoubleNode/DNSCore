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
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1665339641      // 2022-10-09T18:20:41+00:00
    static let defaultDateTimezone: String = "Central Daylight Time"
    static let defaultDateDay: String = "Sunday"
    static let defaultDateMonth: String = "October"
    static let defaultDateYear: String = "2022"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00
    static let nowTenMinutesAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaTenMinutes
    static let nowFortyFiveMinutesAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaFourtyFiveMinutes
    static let nowThreeHoursAgoTimeIntervalSinceNow: TimeInterval = 0 - Date.Seconds.deltaThreeHours
    static let nowTenMinutesInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaTenMinutes
    static let nowFortyFiveMinutesInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaFourtyFiveMinutes
    static let nowThreeHoursInTimeIntervalSinceNow: TimeInterval = Date.Seconds.deltaThreeHours
    static let secondaryTimeZone = TimeZone(abbreviation: "EDT")!
    static let secondaryTimeZoneString: String = "Eastern Daylight Time"

    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateTimezone = DatePrettyFullTests.defaultDateTimezone
    let defaultDateDay = DatePrettyFullTests.defaultDateDay
    let defaultDateMonth = DatePrettyFullTests.defaultDateMonth
    let defaultDateYear = DatePrettyFullTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)
    let nowTenMinutesAgo = Date(timeIntervalSinceNow: nowTenMinutesAgoTimeIntervalSinceNow)
    let nowFortyFiveMinutesAgo = Date(timeIntervalSinceNow: nowFortyFiveMinutesAgoTimeIntervalSinceNow)
    let nowThreeHoursAgo = Date(timeIntervalSinceNow: nowThreeHoursAgoTimeIntervalSinceNow)
    let nowTenMinutesIn = Date(timeIntervalSinceNow: nowTenMinutesInTimeIntervalSinceNow)
    let nowFortyFiveMinutesIn = Date(timeIntervalSinceNow: nowFortyFiveMinutesInTimeIntervalSinceNow)
    let nowThreeHoursIn = Date(timeIntervalSinceNow: nowThreeHoursInTimeIntervalSinceNow)
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
    func test_dnsDate_withNowTenMinutesAgoAndFormatFullPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsDate(as: .fullPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowFortyFiveMinutesAgoAndFormatFullPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsDate(as: .fullPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowThreeHoursAgoAndFormatFullPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsDate(as: .fullPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowTenMinutesInAndFormatFullPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsDate(as: .fullPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowFortyFiveMinutesInAndFormatFullPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsDate(as: .fullPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowThreeHoursInAndFormatFullPretty_shouldReturnString() {
        sut = nowThreeHoursIn
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
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(C.Localizations.DatePretty.justNow)")
    }
    func test_dnsDateTime_withNowTenMinutesAgoAndFormatFullPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsDateTime(as: .fullPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.minutesAgo, "10"))")
    }
    func test_dnsDateTime_withNowFortyFiveMinutesAgoAndFormatFullPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsDateTime(as: .fullPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.minutesAgo, "45"))")
    }
    func test_dnsDateTime_withNowThreeHoursAgoAndFormatFullPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsDateTime(as: .fullPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.hoursAgo, "3"))")
    }
    func test_dnsDateTime_withNowTenMinutesInAndFormatFullPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsDateTime(as: .fullPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.inMinutes, "9"))")
    }
    func test_dnsDateTime_withNowFortyFiveMinutesInAndFormatFullPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsDateTime(as: .fullPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.inMinutes, "44"))")
    }
    func test_dnsDateTime_withNowThreeHoursInAndFormatFullPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsDateTime(as: .fullPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.inHours, "2"))")
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
    func test_dnsTime_withNowTenMinutesAgoAndFormatFullPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsTime(as: .fullPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgo, "10"))
    }
    func test_dnsTime_withNowFortyFiveMinutesAgoAndFormatFullPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsTime(as: .fullPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgo, "45"))
    }
    func test_dnsTime_withNowThreeHoursAgoAndFormatFullPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsTime(as: .fullPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.hoursAgo, "3"))
    }
    func test_dnsTime_withNowTenMinutesInAndFormatFullPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsTime(as: .fullPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutes, "9"))
    }
    func test_dnsTime_withNowFortyFiveMinutesInAndFormatFullPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsTime(as: .fullPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutes, "44"))
    }
    func test_dnsTime_withNowThreeHoursInAndFormatFullPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsTime(as: .fullPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inHours, "2"))
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
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 - Wednesday, September 3, 2031")
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
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 \(C.Localizations.DatePretty.at) 1:20:41pm - " +
            "Wednesday, September 3, 2031 \(C.Localizations.DatePretty.at) 11:32:21am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatFullSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 \(C.Localizations.DatePretty.at) 2:20:41pm - " +
                       "Wednesday, September 3, 2031 \(C.Localizations.DatePretty.at) 12:32:21pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withNowAndEndDateFormatFullPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.justNow) \(C.Localizations.DatePretty.to) Wednesday, September 3, 2031")
    }
}

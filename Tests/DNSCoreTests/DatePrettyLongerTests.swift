//
//  DatePrettyLongerTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyLongerTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1665339641      // 2022-10-09T18:20:41+00:00
    static let defaultDateTimezone: String = "Central Daylight Time"
    static let defaultDateDay: String = "Sun"
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
    let defaultDateTimezone = DatePrettyLongerTests.defaultDateTimezone
    let defaultDateDay = DatePrettyLongerTests.defaultDateDay
    let defaultDateMonth = DatePrettyLongerTests.defaultDateMonth
    let defaultDateYear = DatePrettyLongerTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)
    let nowTenMinutesAgo = Date(timeIntervalSinceNow: nowTenMinutesAgoTimeIntervalSinceNow)
    let nowFortyFiveMinutesAgo = Date(timeIntervalSinceNow: nowFortyFiveMinutesAgoTimeIntervalSinceNow)
    let nowThreeHoursAgo = Date(timeIntervalSinceNow: nowThreeHoursAgoTimeIntervalSinceNow)
    let nowTenMinutesIn = Date(timeIntervalSinceNow: nowTenMinutesInTimeIntervalSinceNow)
    let nowFortyFiveMinutesIn = Date(timeIntervalSinceNow: nowFortyFiveMinutesInTimeIntervalSinceNow)
    let nowThreeHoursIn = Date(timeIntervalSinceNow: nowThreeHoursInTimeIntervalSinceNow)
    let secondaryTimeZone = DatePrettyLongerTests.secondaryTimeZone
    let secondaryTimeZoneString = DatePrettyLongerTests.secondaryTimeZoneString

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

    func test_dnsDate_withDefaultAndFormatLongerSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .longerSimple)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear)")
    }
    func test_dnsDate_withDefaultAndFormatLongerSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .longerSmart)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9")
    }
    func test_dnsDate_withNowAndFormatLongerPretty_shouldReturnString() {
        let result: String = sut.dnsDate(as: .longerPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowTenMinutesAgoAndFormatLongerPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsDate(as: .longerPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowFortyFiveMinutesAgoAndFormatLongerPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsDate(as: .longerPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowThreeHoursAgoAndFormatLongerPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsDate(as: .longerPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowTenMinutesInAndFormatLongerPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsDate(as: .longerPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowFortyFiveMinutesInAndFormatLongerPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsDate(as: .longerPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }
    func test_dnsDate_withNowThreeHoursInAndFormatLongerPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsDate(as: .longerPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }

    func test_dnsDateTime_withDefaultAndFormatLongerSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longerSimple)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) at 1:20pm")
    }
    func test_dnsDateTime_withDefaultAndFormatLongerSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longerSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) at 2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsDateTime_withDefaultAndFormatLongerSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longerSmart)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 \(C.Localizations.DatePretty.at) 1:20:41pm")
    }
    func test_dnsDateTime_withDefaultAndFormatLongerSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDateTime(as: .longerSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 \(C.Localizations.DatePretty.at) 2:20:41pm \(secondaryTimeZoneString)")
    }
    func test_dnsDateTime_withNowAndFormatLongerPretty_shouldReturnString() {
        let result: String = sut.dnsDateTime(as: .longerPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(C.Localizations.DatePretty.justNow)")
    }
    func test_dnsDateTime_withNowTenMinutesAgoAndFormatLongerPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsDateTime(as: .longerPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.minutesAgo, "10"))")
    }
    func test_dnsDateTime_withNowFortyFiveMinutesAgoAndFormatLongerPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsDateTime(as: .longerPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.minutesAgo, "45"))")
    }
    func test_dnsDateTime_withNowThreeHoursAgoAndFormatLongerPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsDateTime(as: .longerPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.hoursAgo, "3"))")
    }
    func test_dnsDateTime_withNowTenMinutesInAndFormatLongerPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsDateTime(as: .longerPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.inMinutes, "9"))")
    }
    func test_dnsDateTime_withNowFortyFiveMinutesInAndFormatLongerPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsDateTime(as: .longerPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.inMinutes, "44"))")
    }
    func test_dnsDateTime_withNowThreeHoursInAndFormatLongerPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsDateTime(as: .longerPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today), \(String(format: C.Localizations.DatePretty.inHours, "2"))")
    }

    func test_dnsTime_withDefaultAndFormatLongerSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longerSimple)
        XCTAssertEqual(result, "1:20pm")
    }
    func test_dnsTime_withDefaultAndFormatLongerSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longerSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "2:20pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndFormatLongerSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longerSmart)
        XCTAssertEqual(result, "1:20:41pm")
    }
    func test_dnsTime_withDefaultAndFormatLongerSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longerSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "2:20:41pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withNowAndFormatLongerPretty_shouldReturnString() {
        let result: String = sut.dnsTime(as: .longerPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.justNow)
    }
    func test_dnsTime_withNowTenMinutesAgoAndFormatLongerPretty_shouldReturnString() {
        sut = nowTenMinutesAgo
        let result: String = sut.dnsTime(as: .longerPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgo, "10"))
    }
    func test_dnsTime_withNowFortyFiveMinutesAgoAndFormatLongerPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesAgo
        let result: String = sut.dnsTime(as: .longerPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.minutesAgo, "45"))
    }
    func test_dnsTime_withNowThreeHoursAgoAndFormatLongerPretty_shouldReturnString() {
        sut = nowThreeHoursAgo
        let result: String = sut.dnsTime(as: .longerPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.hoursAgo, "3"))
    }
    func test_dnsTime_withNowTenMinutesInAndFormatLongerPretty_shouldReturnString() {
        sut = nowTenMinutesIn
        let result: String = sut.dnsTime(as: .longerPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutes, "9"))
    }
    func test_dnsTime_withNowFortyFiveMinutesInAndFormatLongerPretty_shouldReturnString() {
        sut = nowFortyFiveMinutesIn
        let result: String = sut.dnsTime(as: .longerPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inMinutes, "44"))
    }
    func test_dnsTime_withNowThreeHoursInAndFormatLongerPretty_shouldReturnString() {
        sut = nowThreeHoursIn
        let result: String = sut.dnsTime(as: .longerPretty)
        XCTAssertEqual(result, String(format: C.Localizations.DatePretty.inHours, "2"))
    }

    func test_dnsDate_withDefaultAndEndDateFormatLongerSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .longerSimple)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) - Wed, September 3, 2031")
    }
    func test_dnsDate_withDefaultAndEndDateFormatLongerSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .longerSmart)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 - Wed, September 3, 2031")
    }
    func test_dnsDate_withNowAndEndDateFormatLongerPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .longerPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today) \(C.Localizations.DatePretty.to) Wed, September 3, 2031")
    }

    func test_dnsTime_withDefaultAndEndDateFormatLongerSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longerSimple)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) at 1:20pm - " +
            "Wed, September 3, 2031 at 11:32am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatLongerSimpleWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longerSimple, in: secondaryTimeZone)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9, \(defaultDateYear) at 2:20pm - " +
                       "Wed, September 3, 2031 at 12:32pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withDefaultAndEndDateFormatLongerSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longerSmart)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 \(C.Localizations.DatePretty.at) 1:20:41pm - " +
            "Wed, September 3, 2031 \(C.Localizations.DatePretty.at) 11:32:21am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatLongerSmartWithTimezone_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longerSmart, in: secondaryTimeZone)
        XCTAssertEqual(result, "\(defaultDateDay), \(defaultDateMonth) 9 \(C.Localizations.DatePretty.at) 2:20:41pm - " +
                       "Wed, September 3, 2031 \(C.Localizations.DatePretty.at) 12:32:21pm \(secondaryTimeZoneString)")
    }
    func test_dnsTime_withNowAndEndDateFormatLongerPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longerPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.justNow) \(C.Localizations.DatePretty.to) Wed, September 3, 2031")
    }
}

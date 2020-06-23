//
//  DatePrettyShortTests.swift
//  DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyShortTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1602267641      // 2020-10-09T18:20:41+00:00
    static let defaultDateYear: String = "20"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00
    static let defaultEndFromNowDateTimeIntervalSinceNow: TimeInterval = 86400 * 5

    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateYear = DatePrettyShortTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)
    let defaultEndFromNowDate = Date(timeIntervalSinceNow: defaultEndFromNowDateTimeIntervalSinceNow)

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
            TestInterval(start: 0 - Date.Seconds.deltaOneMinute, result: "tdy"),
            TestInterval(start: 0 - Date.Seconds.deltaThreeMinutes, result: "tdy"),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek, result: "1wk ago"),
        ]
        for testInterval in testIntervals {
            sut = Date(timeIntervalSinceNow: testInterval.start + (testInterval.start > 0 ? 20 : -20))
            let result: String = sut.dnsDate(as: .shortPretty)
            XCTAssertEqual(result, testInterval.result)
        }
    }

    func test_dnTime_withDefaultAndFormatShortSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .shortSimple)
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 1:20p")
    }
    func test_dnsTime_withDefaultAndFormatShortSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .shortSmart)
        XCTAssertEqual(result, "10/9, 1:20p")
    }
    func test_dnsTime_withNowAndFormatShortPretty_shouldReturnString() {
        struct TestInterval {
            let start: TimeInterval
            let result: String
        }
        let testIntervals: [TestInterval] = [
            TestInterval(start: 0 - Date.Seconds.deltaOneMinute, result: "1m ago"),
            TestInterval(start: 0 - Date.Seconds.deltaThreeMinutes, result: "3+m ago"),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek, result: "1wk ago"),
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
            TestInterval(start: 0 - Date.Seconds.deltaOneMinute, end: Date.Seconds.deltaTwoHours, result: "tdy"),
            TestInterval(start: 0 - Date.Seconds.deltaThreeMinutes, end: Date.Seconds.deltaOneDay, result: "tdy - tmw"),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek, end: Date.Seconds.deltaSixMinutes, result: "1wk ago - tdy"),
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
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 1:20p - 9/3/31, 11:32a")
    }
    func test_dnsTime_withDefaultAndEndDateFormatShortSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .shortSmart)
        XCTAssertEqual(result, "10/9/\(defaultDateYear), 1:20p - 9/3/31, 11:32a")
    }
    func test_dnsTime_withEndDateFormatShortPretty_shouldReturnString() {
        struct TestInterval {
            let start: TimeInterval
            let end: TimeInterval
            let result: String
        }
        let testIntervals: [TestInterval] = [
            TestInterval(start: 0 - Date.Seconds.deltaOneMinute, end: Date.Seconds.deltaTwoHours, result: "1m ago - 2hrs"),
            TestInterval(start: 0 - Date.Seconds.deltaThreeMinutes, end: Date.Seconds.deltaOneDay, result: "3+m ago - tmw"),
            TestInterval(start: 0 - Date.Seconds.deltaOneWeek, end: Date.Seconds.deltaSixMinutes, result: "1wk ago - 5mins"),
        ]
        for testInterval in testIntervals {
            sut = Date(timeIntervalSinceNow: testInterval.start + (testInterval.start > 0 ? 20 : -20))
            let end = Date(timeIntervalSinceNow:  testInterval.end + (testInterval.end > 0 ? 20 : -20))
            let result: String = sut.dnsTime(to: end, as: .shortPretty)
            XCTAssertEqual(result, testInterval.result)
        }
    }
}
